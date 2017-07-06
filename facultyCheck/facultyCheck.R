#setwd("P:/R programming/facultyCheck")
#install.packages("xlsx")

library(xlsx)

#################################################
loadData <- function(dataFile)
{
  DF = read.csv(dataFile)
  return(DF)
}
#################################################
lData <- file.choose()
DF <-loadData(lData)
#################################################
DF <- subset(DF, DF$Department_Name == c("Law, Faculty of","School of Health Sciences", "Medicine, School of"))
hS <- DF[ which(DF$Department_Name=="School of Health Sciences"),]
law <- DF[ which(DF$Department_Name=="Law, Faculty of"),]
med <- DF[ which(DF$Department_Name=="Medicine, School of"),]
#################################################
write.xlsx(hS, file="outPutPH.xlsx", sheetName="Health Sciences", append=TRUE)
write.xlsx(med, file="outPutPH.xlsx", sheetName="Medicine, School of", append=TRUE)
write.xlsx(law, file="outPutPH.xlsx", sheetName="Law, Faculty of", append=TRUE)
#################################################
