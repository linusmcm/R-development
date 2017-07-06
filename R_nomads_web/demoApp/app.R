library(shiny)
######################################### v#####
ui <- fluidPage()
##############################################
#source files functions called in server function usually inside render function
source("enter_sourcefile_here")
##############################################
#data source either below or  readCSV or similar
dataSource <- readRDS("enter read data source here")
##############################################
server <- function(input, output) 
{
  renderDataTable()
}   
##############################################
##############################################
shinyApp(ui = ui, server = server)