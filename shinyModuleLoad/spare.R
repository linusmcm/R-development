#The checkbox selector is used to determine whether we want an optional column
output$amountflag <- renderUI({
  df <-filedata()
  if (is.null(df)) return(NULL)
  
  checkboxInput("amountflag", "Use values?", FALSE)
})

#If we do want the optional column, this is where it gets created
output$amountCol <- renderUI({
  df <-filedata()
  if (is.null(df)) return(NULL)
  #Let's only show numeric columns
  nums <- sapply(df, is.numeric)
  items=names(nums[nums])
  names(items)=items
  selectInput("amount", "Amount:",items)
})