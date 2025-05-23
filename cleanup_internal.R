#!/usr/bin/env Rscript

# Script to remove redirect files for internally hosted presentations
# This is a one-time cleanup script

library(yaml)
library(fs)

# Read the presentations data
presentations <- read_yaml("_presentations.yml")$presentations

# Get the internal presentation folders
internal_presentations <- presentations[sapply(presentations, function(p) {
  if(!is.null(p$external) && p$external == FALSE) TRUE else FALSE
})]

internal_folders <- sapply(internal_presentations, function(p) p$folder)

cat("Checking for redirect HTML files in internal presentation folders...\n")

for (folder in internal_folders) {
  html_path <- file.path(getwd(), folder, "index.html")
  
  if (file_exists(html_path)) {
    cat("Removing", html_path, "...\n")
    file_delete(html_path)
  } else {
    cat("No HTML file found in", folder, "\n")
  }
}

cat("\nCleanup complete!\n")