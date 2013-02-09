prologues := 2;
filenametemplate "%j-%c.mps";

input graph;
input sarith;

%input TEX; 
%TEXPRE("%&latex" & char(10) & 
%"\documentclass[12pt]{article}\begin{document}"); 
%TEXPOST("\end{document}"); 

verbatimtex
%&latex
\documentclass[8pt]{extarticle}
  \begin{document}
  etex

init_numbers(btex $-$ etex,btex $1$ etex, btex ${\times}10$ etex, btex ${}^-$ etex, btex ${}^2$ etex);

picture ORIGINAL_PICTURE;
ORIGINAL_PICTURE := currentpicture;

picture dd; dd :=
dashpattern(on 4bp off 2bp on 1bp off 2bp);

picture smalldash; smalldash :=
dashpattern(on 2bp off 2bp);

%plot pictures
picture diamond;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm rotated 45;
diamond := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture square;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm;
square := currentpicture; currentpicture := ORIGINAL_PICTURE;
  
picture circle; 
draw fullcircle scaled 0.17cm;
circle := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture dot;
fill fullcircle scaled 0.11cm;
dot := currentpicture; currentpicture := ORIGINAL_PICTURE;
 
picture cross; 
draw (-0.09cm,0.0)--(0.09cm,0.0);
draw (0,-0.09cm)--(0,0.09cm);
cross := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture times; times := cross rotated 45;
%%%%

%legend
picture legendone; 
sx = 0.2cm;
sh = 0.2cm;
ups = 0.35cm;

trans := ups*0;
label.rt(btex CRB etex, (1cm,sh + trans));
draw (sx,sh + trans)--(1cm,sh + trans);

trans := ups*1;
label.rt(btex Approx CRB etex, (1cm,sh + trans));
draw (sx,sh + trans)--(1cm,sh + trans) dashed evenly;

trans := ups*2;
label.rt(btex Simulation etex, (1cm,sh + trans));
%draw (sx,sh + trans)--(1cm,sh + trans) withcolor(0.6,0.6,0.6);
draw dot shifted 1/2[(sx,sh + trans),(1cm,sh + trans)];

legendone := currentpicture; currentpicture := ORIGINAL_PICTURE;

plotheight = 6.4cm;
plotwidth = 7.65cm;


%%%%%%%
% m = 3, p = 0 Gaussian errors plot
beginfig(0);

draw begingraph(plotwidth, plotheight) ;
  setcoords(linear,log);
  glabel.bot(btex SNR dB etex, OUT) shifted(1cm, 1.05cm);
  glabel.lft(btex variance etex, OUT) rotated 90 shifted(1.3cm, 0.55cm);
   
  gdraw "crbN5m2i0"; 
  gdraw "approxcrbN5m2i0" dashed evenly; glabel.llft(btex $\beta_0$ etex, 1000);
  gdraw "simN5m2p0" plot(dot);

  %gdraw "crbN5m2i1"; 
  %gdraw "approxcrbN5m2i1" dashed evenly; glabel.llft(btex $\beta_1$ etex, 1000);
  %gdraw "simN5m2p1" plot(dot);

  gdraw "crbN5m2i2"; 
  gdraw "approxcrbN5m2i2" dashed evenly; glabel.llft(btex $\beta_2$ etex, 1000);
  gdraw "simN5m2p2" plot(dot);

  
  setrange(whatever,whatever, whatever,whatever);
  %otick.lft(btex $10$ etex, 10);
  otick.lft(btex $1$ etex, 1);
  otick.lft(btex $0.1$ etex, 0.1);
  otick.lft(btex $0.01$ etex, 0.01);
  otick.lft(btex $10^{-3}$ etex, 0.001);
  otick.lft(btex $10^{-4}$ etex, 0.0001);
  %for u=auto.y: otick.lft(format("%g",u), u); endfor
  %for u=auto.x: otick.bot(format("%g",u), u); endfor
  autogrid(otick.bot,);
  
 draw legendone shifted(0.07cm, 0.07cm);
 
endgraph;

endfig;

%%%%%%%
% m = 3, p = 0 Gaussian errors plot
beginfig(1);

draw begingraph(plotwidth, plotheight) ;
  setcoords(linear,log);
  glabel.bot(btex SNR dB etex, OUT) shifted(1cm, 1.05cm);
  glabel.lft(btex var $\hat{\beta}_0$ etex, OUT) rotated 90 shifted(1.3cm, 0.55cm);
   
  gdraw "crbN5m2i0"; 
  gdraw "crbN20m2i0";
  gdraw "approxcrbN5m2i0" dashed evenly; glabel.llft(btex $N=5$ etex, 1000);
  gdraw "approxcrbN20m2i0" dashed evenly;  glabel.llft(btex $N=20$ etex, 1000) ;
  gdraw "simN5m2p0" plot(dot);
  gdraw "simN20m2p0" plot(dot);

  setrange(whatever,whatever, whatever,whatever);
  %otick.lft(btex $10$ etex, 10);
  otick.lft(btex $1$ etex, 1);
  otick.lft(btex $0.1$ etex, 0.1);
  otick.lft(btex $0.01$ etex, 0.01);
  otick.lft(btex $10^{-3}$ etex, 0.001);
  %otick.lft(btex $10^{-4}$ etex, "0.0001");
  %for u=auto.y: otick.lft(format("%g",u), u); endfor
  %for u=auto.x: otick.bot(format("%g",u), u); endfor
  autogrid(otick.bot,);
  
 draw legendone shifted(0.07cm, 0.07cm);
 
endgraph;

endfig;

%%%%%%%
% m = 3, p = 0 Gaussian errors plot
beginfig(2);

draw begingraph(plotwidth, plotheight) ;
  setcoords(linear,log);
  glabel.bot(btex SNR dB etex, OUT) shifted(1cm, 1.05cm);
  glabel.lft(btex var $\hat{\beta}_1$ etex, OUT) rotated 90 shifted(1.3cm, 0.55cm);
 
  gdraw "crbN5m2i1"; 
  gdraw "crbN20m2i1"; 
  gdraw "approxcrbN5m2i1" dashed evenly; glabel.llft(btex $N=5$ etex, 1000);
  gdraw "approxcrbN20m2i1" dashed evenly; glabel.llft(btex $N=20$ etex, 1000) ;
  gdraw "simN5m2p1" plot(dot);
  gdraw "simN20m2p1" plot(dot);

  setrange(whatever,whatever, whatever,whatever);
  %otick.lft(btex $10$ etex, 10);
  otick.lft(btex $1$ etex, 1);
  otick.lft(btex $0.1$ etex, 0.1);
  otick.lft(btex $0.01$ etex, 0.01);
  otick.lft(btex $10^{-3}$ etex, 0.001);
  otick.lft(btex $10^{-4}$ etex, 0.0001);
  autogrid(otick.bot,);
  
 draw legendone shifted(0.07cm, 0.07cm);
 
endgraph;

endfig;

%%%%%%%
% m = 3, p = 0 Gaussian errors plot
beginfig(3);

draw begingraph(plotwidth, plotheight) ;
  setcoords(linear,log);
  glabel.bot(btex SNR dB etex, OUT) shifted(1cm, 1.05cm);
  glabel.lft(btex var $\hat{\beta}_2$ etex, OUT) rotated 90 shifted(1.3cm, 1.55cm);
 
  gdraw "crbN5m2i2"; 
  gdraw "crbN20m2i2"; 
  gdraw "approxcrbN5m2i2" dashed evenly; glabel.llft(btex $N=5$ etex, 100);
  gdraw "approxcrbN20m2i2" dashed evenly; glabel.llft(btex $N=20$ etex, 100) ;
  gdraw "simN5m2p2" plot(dot);
  gdraw "simN20m2p2" plot(dot);

  setrange(whatever,whatever, whatever,whatever);
  %otick.lft(btex $10$ etex, 10);
  %otick.lft(btex $1$ etex, 1);
  otick.lft(btex $0.1$ etex, 0.1);
  %otick.lft(btex $0.01$ etex, 0.01);
  otick.lft(btex $10^{-3}$ etex, 0.001);
  %otick.lft(btex $10^{-4}$ etex, 0.0001);
  otick.lft(btex $10^{-5}$ etex, "1e-5");
  %otick.lft(btex $10^{-6}$ etex, "1e-6");
  otick.lft(btex $10^{-7}$ etex, "1e-7");
  autogrid(otick.bot,);
  
 draw legendone shifted(0.07cm, 0.07cm);
 
endgraph;

endfig;

end;

