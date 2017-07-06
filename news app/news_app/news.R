####################################################################
####################################################################  
####################################################################
Sys.setenv("plotly_username"="linus.austen.mcmanamey")
Sys.setenv("plotly_api_key"="3tqgEzyZAGTIeFY5sQ1T")
####################################################################
options(shiny.trace=TRUE)
#options(shiny.fullstacktrace=TRUE)
options(shiny.stacktraceoffset=TRUE)
NEWS_API <<- "5433abdd87a947f8ad94b5d8f2ef3d7d"
####################################################################
####################################################################
install_packages <- function()
{
  list.of.packages <- c("shiny", "tidyverse", "shinythemes", "plotly", "hexbin", "reshape2", "stringr", "rgl","jsonlite" )
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
}
####################################################################  
####################################################################
install_libraries <- function()
{
  library(shiny)
  library(plotly)
  library(rgl)
  library(stringr)
  library(reshape2)
  library(tidyverse)
  library(hexbin)
  library(shinythemes)
  library(jsonlite)
}
####################################################################
all_news_sources <- function()
{
  all_sources <- "https://newsapi.org/v1/sources?language=en"
  raw.data <- readLines(all_sources, warn = "F")
  news_source <- fromJSON(raw.data)
  return(news_source)
}
####################################################################
all_news_catergory <- function(a_n_c)
{
  sources <- paste0("https://newsapi.org/v1/sources?category=",a_n_c)
  raw.data <- readLines(sources, warn = "F")
  news_source <- fromJSON(raw.data)
  return(news_source)
}
####################################################################
select_news_service <- function(news_service)
{
  sources <- paste0("https://newsapi.org/v1/articles?source=",news_service,"&sortBy=latest&apiKey=5433abdd87a947f8ad94b5d8f2ef3d7d")
  raw.data <- readLines(sources, warn = "F")
  news_source <- fromJSON(raw.data)
  return(news_source)
}
####################################################################
####################################################################
select_news_service("the-next-web")
all_news_catergory("technology")
####################################################################