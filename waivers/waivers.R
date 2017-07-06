########################################
installpackages <- function()
{
  install.packages("readxl")
  install.packages("plyr")
  install.packages("readr")
  install.packages('dplyr')
  install.packages('compare')
  install.packages("magrittr")
}
########################################
installLibraries <- function()
{
  library(readxl)
  library(plyr)
  library(readr)
  library(dplyr)
  library(compare)
  library(magrittr)
  library(xlsx)
}
########################################
########################################
load_files_directory <-function()
{
  #filenames <- list.files(path = "C:/Users/lmcmanam/Desktop/temp/allFiles")
  #df <- do.call("rbind", lapply(list.files(path = "C:/Users/lmcmanam/Desktop/temp/allFiles"), read.csv, header = FALSE))
  return(do.call("rbind", lapply(list.files(path = "input/"), read.csv, header = FALSE)))
}
########################################
#installLibraries()
df <- load_files_directory()
