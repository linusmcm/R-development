#install.packages("shiny")
#install.packages("rio")
library(shiny)
library("rio")
source("helper.R")
########################################################
#openFile()
ui <- fluidPage(
      fileInput('datafile', 'Choose CSV file', multiple = FALSE, accept = c('text/csv', 'text/comma-separated-values,text/plain')),
      mainPanel(h3(textOutput("caption")),
                tableOutput(contents)
      )
      )
#######################################################
server <- function(input, output) 
{
  output$contents <- renderTable(
    {
      inFile <- input$file1
      if (is.null(inFile))
        return(NULL)
      
      read.csv(inFile$datapath)
    })
}
#######################################################
shinyApp(ui = ui, server = server)







