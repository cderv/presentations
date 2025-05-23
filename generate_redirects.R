#!/usr/bin/env Rscript

library(yaml)
library(glue)
library(fs)
library(purrr)

# Read the presentations data
presentations <- read_yaml("_presentations.yml")$presentations

# Filter to include only external presentations
external_presentations <- presentations |>
  keep(~ if(is.null(.$external)) FALSE else .$external)

# Read the redirect template
redirect_template <- readLines("_redirect_template.html", warn = FALSE)
redirect_template <- paste(redirect_template, collapse = "\n")

# Function to create a redirect file for a presentation
create_redirect <- function(presentation) {
  # Create folder if it doesn't exist
  folder_path <- file.path(getwd(), presentation$folder)
  if (!dir_exists(folder_path)) {
    dir_create(folder_path)
  }
  
  # Generate the redirect HTML content with explicit variable substitution
  # to avoid issues with 'title' potentially being a function name
  redirect_content <- glue(redirect_template, 
                          title = presentation$title,
                          url = presentation$url,
                          .open = "{{", 
                          .close = "}}")
  
  # Write the redirect file
  writeLines(redirect_content, file.path(folder_path, "index.html"))
  
  cat(glue("Created redirect for '{presentation$title}' in {folder_path}\n"))
}

if (length(external_presentations) > 0) {
  # Create redirects for all external presentations
  walk(external_presentations, create_redirect)
  cat("\nAll redirects have been generated successfully!\n")
} else {
  cat("No external presentations found.\n")
}