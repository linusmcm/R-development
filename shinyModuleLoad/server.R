library(shiny)

function(input, output) 
{
  #This function is repsonsible for loading in the selected file
  filedata <- reactive({
    infile <- input$datafile
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    read.csv(infile$datapath)
  })
  
  output$filetable <- renderTable(
    {
    filedata()
    })
  
  
  output$toCol <- renderUI({
    df <-filedata$DEPARTMENT_NAME()
    if (is.null(df)) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("to", "To:",items)
    
  })
  
}
