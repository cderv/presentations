all: prez
.PHONY: all prez prez_sc

prez:
		Rscript -e "source('render.R');render_prez(FALSE)"

prez_sc: MEETUP_R-Rex_Datalab.Rmd
		Rscript -e "source('render.R');render_prez(TRUE)"
