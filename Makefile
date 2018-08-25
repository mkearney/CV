.PHONY: all clean
all:
	@echo Build all
	xelatex cv.tex
	open -a preview cv.pdf
clean:
	@echo Clean all
	rm *.out *.log *.aux
