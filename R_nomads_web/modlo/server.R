library(shiny)
library(DT)
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

# Define a server for the Shiny app
shinyServer(function(input, output, session) {
  
  # Filter data based on selections
  filedata <- reactive(
    {
    infile <- input$datafile
    if (is.null(infile)) 
      {
      # User has not uploaded a file yet
      return(NULL)
      }
    read.csv(infile$datapath)
    }
    )
  
  #output$DF <- filedata()
  output$table <- DT::renderDataTable(DT::datatable(
    {
    data <- filedata()
    if (input$SEMESTER != "All") 
      {
      data <- data[data$SEMESTER == input$SEMESTER,]
      }
    if (input$DEPARTMENT_NAME != "All") 
      {
      data <- data[data$DEPARTMENT_NAME == input$DEPARTMENT_NAME,]
    }
    keepRows <- c("NAME", "DESCRIPTION", "SEMESTER", "DEPARTMENT_NAME", "PLANNEDSIZE", "AUDIT_ACTION", "HOSTKEY")
    data <- data[keepRows]
    data
  }), escape = TRUE)
  
  output$DepartmentName <- renderUI(
    {
    df <-filedata()
    selectInput("DEPARTMENT_NAME", "DEPARTMENT_NAME:", c("All", unique(as.character(df$DEPARTMENT_NAME))))
    })
  
  output$Semester <- renderUI(
    {
      df <-filedata()
      selectInput("SEMESTER", "SEMESTER:", c("All", unique(as.character(df$SEMESTER))))
    })
  
    
})