# Script to copy README_files to _site and delete original

tryCatch(
  {
    if (fs::dir_exists('README_files')) {
      # Create destination directory
      fs::dir_create(fs::path('_site', 'README_files'), recurse = TRUE)

      # Get all files in README_files
      readme_files <- fs::dir_ls('README_files', type = 'file', recurse = TRUE)

      # Copy each file to appropriate destination
      for (file in readme_files) {
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
      # Delete original README_files directory
      fs::dir_delete('README_files')
      cat('README_files moved to _site/README_files\n')
    }
  },
  error = function(e) {
    cat('Warning: Could not process README_files:', e$message, '\n')
  }
)
