new_prez <- "meetupr-pagedown"
fs::dir_create(new_prez)
to_copy <- c("Makefile", "render.R", "custom.css")
fs::file_copy(fs::path("MEETUPR-DATALAB/", to_copy), new_prez)
withr::with_dir(
  new_prez, {
    if (!fs::file_exists(rmd <- fs::path_ext_set(new_prez, "Rmd"))) {
      message("creating new file")
      fs::file_create(fs::path_ext_set(new_prez, "Rmd"))
    }
    file.edit(fs::path(new_prez, fs::path_ext_set(new_prez, "Rmd")))
    # get remark.js
    xaringan::summon_remark()
  }
)
