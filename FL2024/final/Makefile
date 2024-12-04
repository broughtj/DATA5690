all:
		@rm -f biblio.bib
		@rm -f biblio.pdf
		python ./assets/build.py
		pandoc ./biblio.bib --citeproc --metadata title="References" --csl ./assets/asa.csl -s -o biblio.pdf

biblio:
		python ./assets/build-biblio.py

pdf:
		pandoc ./biblio.bib --citeproc --metadata title="References" --csl ./assets/asa.csl -s -o biblio.pdf

entry:
		#python ./assets/newbib.py
		#./assets/entry.fish
		python ./assets/bib-to-markdown-converter.py

today:
		python ./assets/daily.py

zettel:
		#python ./assets/zettel.py
		python ./assets/zettel-note-creator.py

clean:
		@rm -f biblio.bib
		@rm -f biblio.pdf
