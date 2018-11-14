.PHONY: all clean
all:
	@echo Compiling CV...
	xelatex cv.tex
clean:
	@echo Removing aux files...
	rm *.out *.log *.aux
