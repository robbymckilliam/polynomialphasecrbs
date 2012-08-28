cd code 
mpost -interaction=nonstopmode plot.mp 
cd .. 

pdflatex paper.tex
bibtex paper.aux
pdflatex paper.tex
pdflatex paper.tex

