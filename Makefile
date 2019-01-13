.PHONY: all clean
all:
	Rscript R/make.R
clean:
	@echo Removing aux files...
	rm *.out *.log *.aux
