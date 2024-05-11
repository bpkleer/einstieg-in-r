library(tidyverse)

replace_string_in_files <- function(folder_path) {
  # List all files in the specified folder with .md or .Rmd extension
  files <- list.files(path = folder_path, pattern = "\\.md$|\\.Rmd$", full.names = TRUE, recursive = TRUE)
  
  # Loop through each file
  for (file in files) {
    # Read the content of the file
    file_content <- readLines(file, warn = FALSE)
    
    if (endsWith(file, ".Rmd")) {
      search_string <- "\\?subject=Schau\\\\%20dir\\\\%20das\\\\%20mal\\\\%20an\\\\%3A\\\\%20"
      replace_string <- ''
      
      search <- str_detect(file_content, search_string)
      
      if (any(TRUE %in% search)) {
        file_content <- str_replace(file_content, search_string, replace_string)
        
        writeLines(file_content, file)
      }
      
    } else if (endsWith(file, ".md")) {
      search_string <- "\\?subject=Schau\\%20dir\\%20das\\%20mal\\%20an\\%3A\\%20"
      replace_string <- ''
      
      search <- str_detect(file_content, search_string)
      
      if (any(TRUE %in% search)) {
        file_content <- str_replace(file_content, search_string, replace_string)
        
        writeLines(file_content, file)
      }
    }
  }
}

# Example usage:
folder_path <- "./content"

replace_string_in_files(folder_path)
