
# render
callr::r(function(){
  rmarkdown::render(
    "MEETUPR_28-05-2018-DATALAB/MEETUP_R-Rex_Datalab.Rmd",
    output_file = "index.html",
    output_options = list(chakra = "https://remarkjs.com/downloads/remark-latest.min.js"),
    encoding = "UTF-8"
  )
})
