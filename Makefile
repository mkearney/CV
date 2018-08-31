.PHONY: all clean
all:
	@echo Compiling CV...
	xelatex cv.tex
	rm *.out *.log *.aux
	open -a preview cv.pdf
clean:
	@echo Removing aux files...
	rm *.out *.log *.aux
