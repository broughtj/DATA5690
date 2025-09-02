.PHONY: help pdf html clean preview all

help:
	@echo "DATA 5690-6690 Midterm 1 - Available Commands:"
	@echo ""
	@echo "  pdf      - Render the midterm to PDF format"
	@echo "  html     - Render the midterm to HTML format"
	@echo "  preview  - Start Quarto preview server"
	@echo "  clean    - Remove generated files"
	@echo "  all      - Render to both PDF and HTML"
	@echo "  help     - Display this help message"
	@echo ""
	@echo "Usage: make [command]"

pdf:
	quarto render --to pdf

html:
	quarto render --to html

preview:
	quarto preview

clean:
	rm -rf _book/ midterm1.pdf midterm1.html .quarto/

all: pdf html
