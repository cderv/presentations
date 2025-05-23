# Script to create site directory and handle index.html file

# Create _site directory if it doesn't exist
if (!fs::dir_exists('_site')) {
  fs::dir_create('_site')
}

# Move index.html to _site directory if it exists
if (fs::file_exists('index.html')) {
  fs::file_copy('index.html', '_site/')
  fs::file_delete('index.html')
}
