#################################################
setwd("P:/R programming/moduleLoads")
#################################################
install.packages("xlsx")
install.packages("stringr")
library(xlsx)
library(stringr)
#################################################
departments <- list("Law, Faculty of","School of Health Sciences", "School of Medicine")
#################################################
loadData <- function(dataFile)
{
  DF = read.csv(dataFile)
  return(DF)
}
#################################################
dropRows <- function(dF)
{
  keeps <- c("NAME","DESCRIPTION", "SEMESTER", "DEPARTMENT", "DEPARTMENT_NAME", "subCode", "HOSTKEY")
  return(dF[keeps])
}
#################################################
#################################################
lData <- file.choose()
DF <-loadData(lData)
#################################################
DF<- dropRows(DF)
DF <- subset(DF, DF$DEPARTMENT_NAME == c("Law, Faculty of","School of Health Sciences", "School of Medicine"))
DF$subCode <- substr(DF$NAME, 1, 3)
hS <- DF[ which(DF$DEPARTMENT_NAME=="School of Health Sciences"),]
law <- DF[ which(DF$DEPARTMENT_NAME=="Law, Faculty of"),]
med <- DF[ which(DF$DEPARTMENT_NAME=="School of Medicine"& DF$subCode =="KHA"),]

#################################################
write.xlsx(hS, file="outPut.xlsx", sheetName="Health Sciences", append=TRUE)
write.xlsx(med, file="outPut.xlsx", sheetName="School of Medicine", append=TRUE)
write.xlsx(law, file="outPut.xlsx", sheetName="Law, Faculty of", append=TRUE)





noMed <- subset(DF, DF$NAME =="KHA")

hS <- DF[ which(DF$DEPARTMENT_NAME=="School of Health Sciences" & DF$AUDIT_ACTION == "U"),]
hS_SEM1<- lDat[ which(DF$DEPARTMENT_NAME=="School of Health Sciences" & lDat$AUDIT_ACTION == "U" & lDat$SEMESTER == "SEM01" ),]
hS_SEM1 <- dropRows(hS_SEM1)
# write each semester to a sheet , maybe look at "shiny" to develope an app 
# "CXA", "CNA", "CSA"
sub <- substr(DF$NAME, 1, 3)
