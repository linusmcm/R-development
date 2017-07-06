#################################################
setwd("P:/R programming/nameAvaliabilities")
#################################################
#install.packages("xlsx")
#install.packages("Hmisc")
#install.packages("compare")
#library(Hmisc)
#library(xlsx)
#library(compare)
#################################################
loadData <- function(dataFile)
{
  return(read.csv(dataFile))
}
#################################################
difference <- function(first,second )
{
  return(setdiff(second, first))
}
#################################################
dropRows <- function(dF)
{
  keeps <- c("HOSTKEY", "studyPeriod","start", "finish")
  return(dF[keeps])
}
#################################################
#################################################
#################################################
#################################################
#naV <- loadData("naV.csv")
#naS_plus_2017 <- loadData("naS_plus_2017.csv")
#################################################
naV <- loadData("web.csv")
naS_plus_2017 <- loadData("sPlus.csv")
naS <- dropRows(naS_plus_2017)
naV <- naV[order(naV$studyPeriod),]
naS <- naS[order(naS$studyPeriod),]

intersect_test <- intersect(naV$studyPeriod, naS$studyPeriod)
union_test <- union(naV$studyPeriod, naS$studyPeriod)

studyPeriodDiff <- difference(naV$studyPeriod, naS$studyPeriod)
naSS <- subset(naS, studyPeriod %nin% studyPeriodDiff)
naSS<- naSS[order(naSS$studyPeriod),]
################################################
diffStart <- setdiff(naSS$start, naV$start)
diffFinish <- setdiff(naSS$finish, naV$finish)
startDateSS <- subset(naSS, finish %in% diffFinish)
################################################
diffStart1 <- setdiff(naV$start, naSS$start)
startDate <- subset(naV, start %in% diffStart1)
diffFinish1 <- setdiff(naV$finish, naSS$finish)
FinshDate <- subset(naV, finish %in% diffFinish1)
studyPeriodDiff <- data.frame(studyPeriodDiff)
#wrirte to one excel sheet
write.xlsx(startDate, file="outPut.xlsx", sheetName="start Dates web", append=TRUE)
write.xlsx(FinshDate, file="outPut.xlsx", sheetName="finish Dates web", append=TRUE)
write.xlsx(startDateSS, file="outPut.xlsx", sheetName="finish Dates Splus", append=TRUE)
write.xlsx(studyPeriodDiff, file="outPut.xlsx", sheetName="does not exist on web ", append=TRUE)

