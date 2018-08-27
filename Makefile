.PHONY: all clean
all:
	@echo Build all
	xelatex cv.tex
	rm *.out *.log *.aux
	open -a preview cv.pdf
clean:
	@echo Clean all
	rm *.out *.log *.aux
