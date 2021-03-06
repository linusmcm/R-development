####################################################################
source("news.R")
install_packages()
install_libraries()
####################################################################
#all_news_sources <- all_news_sources()
####################################################################
ui <- fluidPage(
  
  # Application title
  titlePanel("Reactivity"),
  
  # Sidebar with controls to provide a caption, select a dataset,
  # and specify the number of observations to view. Note that
  # changes made to the caption in the textInput control are
  # updated in the output area immediately as you type
  sidebarLayout(
    sidebarPanel(
      textInput("caption", "Caption:", "Data Summary"),
      
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("rock", "pressure", "cars")),
      
      numericInput("obs", "Number of observations to view:", 10)
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML 
    # table with the requested number of observations
    mainPanel(
      h3(textOutput("caption", container = span)),
      
      verbatimTextOutput("summary"), 
      
      tableOutput("view")
    )
  )
)
####################################################################
library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected
# dataset
function(input, output) 
{
  

  datasetInput <- reactive({  switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  #  1) This function is automatically called to recompute the 
  #     output 
  #  2) The new caption is pushed back to the browser for 
  #     re-display
  # 
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$caption, those expressions are
  # NOT called when input$caption changes.
  output$caption <- renderText({
    input$caption
  })
  
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated
  # (i.e. whenever the input$dataset changes)
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so will be re-executed whenever
  # input$dataset or input$obs is changed. 
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
}
####################################################################
# Run the application 
shinyApp(ui = ui, server = server)
####################################################################

