
# render
render_prez <- function(self_contained = FALSE) {
  to_render <- here::here("MEETUPR_28-05-2018-DATALAB", "MEETUP_R-Rex_Datalab.Rmd")
  html_output <- if (self_contained) "self_contained.html" else "index.html"
  chakra <- if (self_contained) "libs/remark-latest.min.js" else "https://remarkjs.com/downloads/remark-latest.min.js"
  rmarkdown::render(
    to_render,
    output_file = html_output,
    output_options = list(chakra = chakra,
                          self_contained = self_contained),
    encoding = "UTF-8"
  )
  # callr::r(function(to_render, html_output, chakra){
  #   rmarkdown::render(
  #     to_render,
  #     output_file = html_output,
  #     output_options = list(chakra = chakra,
  #                           self_contained = self_contained),
  #     encoding = "UTF-8"
  #   )
  # })
}

  # Self contained
  # callr::r(function(){
  #   rmarkdown::render(
  #     "MEETUPR_28-05-2018-DATALAB/MEETUP_R-Rex_Datalab.Rmd",
  #     output_file = "self_contained.html",
  #     output_options = list(chakra = "libs/remark-latest.min.js", self_contained = TRUE),
  #     encoding = "UTF-8"
  #   )
  # })
