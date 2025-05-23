all: readme redirects

.PHONY: readme redirects clean

readme:
	@echo "Rendering README.md from README.qmd..."
	quarto render README.qmd
	@echo "README.md updated!"

redirects:
	@echo "Generating redirect HTML files for external presentations..."
	Rscript generate_redirects.R
	@echo "Redirects generated!"

clean:
	@echo "Removing generated redirect HTML files..."
	@Rscript -e "library(yaml); p <- read_yaml('_presentations.yml')$$presentations; ext <- sapply(p, function(x) if(is.null(x$$external)) FALSE else x$$external); folders <- sapply(p[ext], function(x) x$$folder); for (f in folders) { file <- file.path(f, 'index.html'); if (file.exists(file)) { cat('Removing', file, '\n'); file.remove(file) } }"
	@echo "Done cleaning!"

update: clean all