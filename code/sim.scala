/**
 * Monte-Carlo simulations with the maximum likelihood estimator of
 * a polynomial phase signal.
 */
import pubsim.poly.PolynomialPhaseSignal
import pubsim.poly.MaximumLikelihood
import pubsim.distributions.GaussianNoise
import pubsim.poly.PolynomialPhaseEstimator

val iters = 10000 //number of Monte-Carlo trials.
val Ns = List(10,20) //values of N we will generate curves for
val ms = List(2) //order of our polynomial phase signals
val snrdbs = -5 to 25
val fourpisqr = 4.0*scala.math.Pi*scala.math.Pi

//returns an array of noise distributions with a logarithmic scale
def noises = snrdbs.map( snrdb => new GaussianNoise(0,scala.math.pow(10.0,-snrdb/10.0)/2.0) )

//Return estimators we will run (factory patern to enable parallelism)
def estfactory(m : Int, N : Int) : () => PolynomialPhaseEstimator = {
    () => new MaximumLikelihood(m,N)
}

val starttime = (new java.util.Date).getTime

//for all the the values of N and m.
for( N <-  Ns; m <- ms ) {

  val estf = estfactory(m,N)
    
    val estname = "simN" + N.toString + "m" + m
    print("Running " + estname)
    val eststarttime = (new java.util.Date).getTime
    
    //for all the noise distributions (in parallel threads)
    val mselist = noises.par.map { noise =>

      val siggen =  new PolynomialPhaseSignal(N) //construct a signal generator
      siggen.setNoiseGenerator(noise)
      val est = estf() //construct an estimator
				  
      var mse = new Array[Double](m+1) //storage for the mses
      for( itr <- 1 to iters ) {
	siggen.generateRandomParameters(m)
	val p0 = siggen.getParameters
	siggen.generateReceivedSignal
	val err = est.error(siggen.getReal, siggen.getImag, p0)
	for( i <- mse.indices ) mse(i) += err(i) 
      }
      print(".")
      mse //last thing is what gets returned 
    }.toList
    
    //now write all the data to a file
    val files = (0 to m).map( v => new java.io.FileWriter("data/" + estname + "p" + v) ) //list of files to write to
    (mselist, snrdbs).zipped.foreach{ (mse, snrdb) =>
      for ( i <- files.indices ) 
	files(i).write(snrdb.toString.replace('E', 'e') + "\t" + (fourpisqr*mse(i)/iters).toString.replace('E', 'e')  + "\n") 
    }
    for( f <- files ) f.close //close all the files we wrote to 
    
    val estruntime = (new java.util.Date).getTime - eststarttime
    println(" finished in " + (estruntime/1000.0) + " seconds.")
  
}

val runtime = (new java.util.Date).getTime - starttime
println("Simulation finshed in " + (runtime/1000.0) + " seconds.\n")
