# Clean script - removes redirect files and _site directory

# Clean redirect HTML files
p <- yaml::read_yaml('_presentations.yml')$presentations
ext <- sapply(p, function(x) if (is.null(x$external)) FALSE else x$external)
folders <- sapply(p[ext], function(x) x$folder)

for (f in folders) {
  file_path <- fs::path(f, 'index.html')
  if (fs::file_exists(file_path)) {
    cat('Removing', file_path, '\n')
    fs::file_delete(file_path)
  }
}

# Remove _site directory if it exists
if (fs::dir_exists('_site')) {
  fs::dir_delete('_site')
}
