#setwd("P:/R programming/allUnits")
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
DF$subCode <- substr(DF$Name, 1, 3)
DFS <- subset(DF, DF$subCode == c("LAW","LCA","KHA","CXA","CNA"))
DFS <- DF[ which(DF$Name == c("LAW","LCA","KHA","CXA","CNA")),]

LAW <- subset(DF, DF$subCode == "LAW")
LCA <- subset(DF, DF$subCode == "LCA")
KHA <- subset(DF, DF$subCode == "KHA")
CXA <- subset(DF, DF$subCode == "CXA")
CNA <- subset(DF, DF$subCode == "CNA")


write.xlsx(CNA, file="MyModules.xlsx", sheetName="CNA", append=TRUE)
write.xlsx(CXA, file="MyModules.xlsx", sheetName="CXA", append=TRUE)
write.xlsx(KHA, file="MyModules.xlsx", sheetName="KHA", append=TRUE)
write.xlsx(LAW, file="MyModules.xlsx", sheetName="LAW", append=TRUE)
write.xlsx(LCA, file="MyModules.xlsx", sheetName="LCA", append=TRUE)