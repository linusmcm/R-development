#################################################
loadData <- function(dataFile)
{
  DF = read.csv(dataFile)
  return(DF)
}
#################################################
#deduped.data <- unique( yourdata[ , 1:3 ] )


openFile <- function()
{
  return(read.csv(file.choose()))
}