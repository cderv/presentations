all: readme

.PHONY: readme redirects clean site update

readme: README.qmd
	@echo "Rendering README.md from README.qmd..."
	quarto render README.qmd
	@echo "README.md updated!"

redirects: _presentations.yml generate_redirects.R
	@echo "Generating redirect HTML files for external presentations..."
	Rscript generate_redirects.R
	@echo "Redirects generated!"

clean: scripts/clean.R
	@echo "Removing generated redirect HTML files..."
	@Rscript scripts/clean.R
	@echo "Done cleaning!"

index.html: README.qmd
	@echo "Rendering index.html from README.qmd..."
	quarto render README.qmd --to html -o index.html
	@echo "index.html generated!"

site: update redirects index.html scripts/site_setup.R scripts/copy_readme_files.R scripts/copy_presentations.R
	@echo "Creating site directory structure..."
	@Rscript scripts/site_setup.R
	@Rscript scripts/copy_readme_files.R
	@Rscript scripts/copy_presentations.R
	@echo "Site directory structure created at _site/"

update: clean readme