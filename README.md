Repository for paper

Robby McKilliam and Andre Pollok "On the Cramer-Rao bound for polynomial phase signals".

You can build the plots and tex by running the build.sh bash script.  If you can't run a bash script then open up build.sh to see the required commands.

Data from the simulations already exists in this repository (the same data as used in the paper).  If you would like to rerun the Monte-Carlo simulations use the runsim.sh script in the /code directory. You need a working java jvm and also Scala 2.9.1 or higher installed. The simulations make use of code from the PubSim library, available at

https://github.com/robbymckilliam/pubsim.

A build of this library exists in this repository.  The Cramer-Rao bounds were calculated using Mathematica 8.0. See the crbcomputer.nb file in the /code directory.

