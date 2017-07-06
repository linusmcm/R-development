
shinyUI(
  fluidPage(
    titlePanel("S+ module load check"),
    # Create a new Row in the UI for selectInputs
    fluidRow(
    column(3 ,fileInput('datafile', 'Please choose the CSV file to upload:',accept=c('text/csv', 'text/comma-separated-values,text/plain'))),
    column(3 ,uiOutput("DepartmentName")),
    column(3 ,uiOutput("Semester"))
    ),
    # Create a new row for the table.
    fluidRow(
      DT::dataTableOutput("table")
    )
  )
)