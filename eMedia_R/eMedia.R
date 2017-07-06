#################################################
#setwd("C:/Users/lmcmanam/Desktop/eMedia_R")
#################################################
install.packages("xlsx")
library(xlsx)
#################################################
loadData <- function(dataFile)
{
  d_csv = read.csv(dataFile)
  DF <- data.frame(d_csv)
  return(DF)
}
#################################################
difference <- function(first,second )
{
  diff <- setdiff(second$roomName, first$roomName)
  return(diff)
}
#################################################
writeExcel <- function(value)
{
write.xlsx(value, "outPutEmedia.xlsx")
}
#################################################
#################################################
writeList_to_excel <- function(theList)
{
  #writes list as dataframe to file
  lapply(theList, function(x) write.table( data.frame(x), 'outPut.csv'  , append= T, sep=',' ))
}
#################################################
uneven_list_to_data_frame <- function(theList)
{
  #returns a data frame
  return(lapply(theList, function(x) data.frame(x)))
}
#################################################
seventeen <- loadData("2017.csv")
sixteen <- loadData("2016.csv")
appliances <- loadData("Appliances.csv")
myLo <- loadData("myLo.csv")
six_to_seven <- difference(seventeen, sixteen)
seven_myLO <- difference(seventeen, myLo)
Seven_To_appliances <- difference(seventeen, appliances)
dList <- list(six_to_seven, seven_myLO, Seven_To_appliances)
DF <- uneven_list_to_data_frame(dList)
writeList_to_excel(dList)
writeExcel(DF)
#################################################





