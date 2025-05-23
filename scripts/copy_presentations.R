# Script to copy presentation folders to _site

tryCatch(
  {
    # Read presentations from YAML
    p <- yaml::read_yaml('_presentations.yml')$presentations
    folders <- sapply(p, function(x) x$folder)

    # Copy each presentation folder
    for (f in folders) {
      if (fs::dir_exists(f)) {
        # Create destination directory
        fs::dir_create(fs::path('_site', f), recurse = TRUE)

        # Get all files in the presentation folder
        files <- fs::dir_ls(f, type = 'file', recurse = TRUE)

        # Copy each file to appropriate destination
        for (file in files) {
          dest_dir <- fs::path('_site', fs::path_dir(file))

          if (!fs::dir_exists(dest_dir)) {
            fs::dir_create(dest_dir, recurse = TRUE)
          }

          fs::file_copy(
            file,
            fs::path(dest_dir, fs::path_file(file)),
            overwrite = TRUE
          )
        }
      }
    }
  },
  error = function(e) {
    cat('Warning:', e$message, '\n')
  }
)
