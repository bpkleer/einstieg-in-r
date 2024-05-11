copy_change_md <- function(source_folder, destination_folder, new_extension) {
  # Check if destination folder exists, create if not
  if (!file.exists(destination_folder)) {
    dir.create(destination_folder)
  }
  
  # List all .md files in the source folder
  md_files <- list.files(source_folder, pattern = "\\.md$", full.names = TRUE)
  
  # Iterate through each .md file
  for (file in md_files) {
    # Get the file name
    file_name <- basename(file)
    
    # Get the file name without extension
    file_name_without_extension <- tools::file_path_sans_ext(file_name)
    
    # Get the full path of the destination file with new extension
    destination_file_path <- file.path(destination_folder, paste0(file_name_without_extension, new_extension))
    
    # Copy the .md file to the destination folder and rename it with new extension
    file.copy(file, destination_file_path)

  }

}

copy_change_rmd <- function(source_folder, destination_folder, new_extension) {
  # Check if destination folder exists, create if not
  if (!file.exists(destination_folder)) {
    dir.create(destination_folder)
  }
  
  # List all .md files in the source folder
  md_files <- list.files(source_folder, pattern = "\\.Rmd$", full.names = TRUE)
  
  # Iterate through each .md file
  for (file in md_files) {
    # Get the file name
    file_name <- basename(file)
    
    # Get the file name without extension
    file_name_without_extension <- tools::file_path_sans_ext(file_name)
    
    # Get the full path of the destination file with new extension
    destination_file_path <- file.path(destination_folder, paste0(file_name_without_extension, new_extension))
    
    # Copy the .md file to the destination folder and rename it with new extension
    file.copy(file, destination_file_path)
  }

}

transfer <- function(source_folder, destination_folder) {
  # delete old files in source folder
  files <- list.files(source_folder, pattern = "\\.md$", full.names = TRUE)
  
  for (file in files) {
    # Delete the original .md file
    file.remove(file)
  }
  
  # delete md-files
  files <- list.files(source_folder, pattern = "\\.Rmd$", full.names = TRUE)
  
  for (file in files) {
    # Delete the original .md file
    file.remove(file)
  }
  
  # List all files in the destination folder
  destination_files <- list.files(destination_folder, full.names = TRUE)
  
  # Transfer files from the destination folder back to the source folder
  for (file in destination_files) {
    # Get the file name
    file_name <- basename(file)
    
    # Get the full path of the file in the source folder
    source_file_path <- file.path(source_folder, file_name)
    
    # Transfer the file from destination folder to source folder
    file.rename(file, source_file_path)
  }
  
  # Delete the destination folder
  unlink(destination_folder, recursive = TRUE)
}

languages <- c("de", "en", "pt")

source_folder <- "./content/chapter3"
destination_folder <- "./content/chapter3/new"

for (i in 1:3) {
  new_extension_md <- paste0(".", languages[i], ".md")
  new_extension_rmd <- paste0(".", languages[i], ".Rmd")
  
  copy_change_md(source_folder, destination_folder, new_extension_md)
  copy_change_rmd(source_folder, destination_folder, new_extension_rmd)
}

transfer(source_folder, destination_folder)



