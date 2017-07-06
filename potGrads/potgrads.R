########################################
########################################
#potgrads.R
#Linus McManamey
#Feb 2017
########################################
installpackages <- function()
{
  install.packages("readxl")
  install.packages("plyr")
  install.packages("readr")
  install.packages('dplyr')
  install.packages('compare')
  install.packages("magrittr")
}
########################################
installLibraries <- function()
{
  library(readxl)
  library(plyr)
  library(readr)
  library(dplyr)
  library(compare)
  library(magrittr)
}
########################################
########################################
########################################
#loadData <- function()
#{
#  filenames <- list.files(path = "~/")
#  df <- do.call("rbind", lapply(filenames, read.csv, header = FALSE))
#  return(df)
#}
########################################
########################################
createDataFrame <- function(test)
{
  return(data.frame(test))
}
########################################
createStudentID  <- function(df)
{
  df$studentID <-sub('\\D*(\\d{6}).*', '\\1',  df$V6)
  return(df)
}
########################################
createYear  <- function(df)
{
  df$year <-sub('\\D*(\\d{4}).*', '\\1',  df$V20)
  return(df)
}
########################################
renameDF <- function(df)
{
  names(df)[names(df)=="V28"] <- "grade"
  names(df)[names(df)=="V22"] <- "unit"
  names(df)[names(df)=="V41"] <- "commenced"
  names(df)[names(df)=="V26"] <- "mark"
  names(df)[names(df)=="V24"] <- "unit_weight"
  names(df)[names(df)=="V20"] <- "course"
  names(df)[names(df)=="V21"] <- "semester"
  names(df)[names(df)=="V38"] <- "course_name"
  names(df)[names(df)=="V27"] <- "grade_code"
  names(df)[names(df)=="V25"] <- "CP"
  names(df)[names(df)=="V35"] <- "DR"
  return(df)
}
########################################
deans_roll <- function(df)
{
 return(ifelse(df$grade_code == 'HD',7, ifelse(df$grade_code == 'DN', 6, ifelse(df$grade_code == 'CR', 5, ifelse(df$grade_code == 'PP', 4, 0)))))
}
########################################
loadData <- function(dataFile)
{
  DF = read.csv(dataFile, header = FALSE, stringAsFactor = FALSE)
  return(DF)
}
########################################
load_files_directory <-function()
{
  #filenames <- list.files(path = "C:/Users/lmcmanam/Desktop/temp/allFiles")
  #df <- do.call("rbind", lapply(list.files(path = "C:/Users/lmcmanam/Desktop/temp/allFiles"), read.csv, header = FALSE))
  return(do.call("rbind", lapply(list.files(path = "C:/Users/lmcmanam/Desktop/temp/allFiles"), read.csv, header = FALSE)))
}
########################################
strip_files <- function(df)
{
  testDF <- subset(df, select = c(year,grade,unit,commenced,studentID, mark,unit_weight, course, semester, course_name, grade_code, CP,DR))
  testDF <- testDF[testDF$grade_code!="XE" & testDF$grade_code!="NN" & testDF$grade_code!=""& testDF$grade_code!="AN"& testDF$grade_code!="EX" & testDF$grade_code!="UP", ]
  testDF <- testDF[testDF$grade_code!="EL3" & testDF$grade_code!="EL4" & testDF$grade_code!="EL2"& testDF$grade_code!="EL0", ]
  testDF <- testDF[testDF$grade =="PASS", ]
  testDF <- testDF[grepl("Nursing", testDF$course),]
  return(testDF)
}
########################################
strip_and_write <- function()
{
  uYear<- sort(unique(testDF$year),decreasing = TRUE)
  uYear <- uYear [1:3]
  for(i in uYear)
  {
    output <- testDF %>%  filter(year == i) %>% select(year,grade,unit,commenced,studentID, mark,unit_weight, course, semester, course_name, grade_code, CP,DR)
    output <- output %>% group_by(studentID) %>% summarise(mean_DR=mean(DR), sumCP = sum(CP)) %>%  filter(mean_DR >= 6.25, sumCP >= 100) %>%  select(studentID, sumCP, mean_DR)
    uO <- unique(output$studentID)
    matches <- intersect(students$studentID,uO)
    if(length(output) > 0)
    {
      write.xlsx(output, file="../output/deansRoll.xlsx", sheetName = paste(i), append=TRUE, col.names=TRUE, row.names=TRUE, showNA=TRUE)
    }
    if(length(matches) > 0)
    {
      write.xlsx(matches, file="../output/deansRoll.xlsx", sheetName = paste("matches_",  i), append=TRUE, col.names=TRUE, row.names=TRUE, showNA=TRUE)
    }
    output <- testDF %>%  filter(year == i) %>% select(studentID, year,semester,grade,unit,commenced, mark,unit_weight, course, semester, course_name, grade_code, CP,DR)
    output <- output %>% group_by(studentID) %>% summarise(mean_DR=mean(DR), sumCP = sum(CP)) %>%  filter(mean_DR >= 6.25, sumCP > 49 & sumCP < 100) %>%  select(studentID, sumCP, mean_DR)
    uO <- unique(output$studentID)
    matches <- intersect(students$studentID,uO)
    if(length(matches) > 0)
    {
      write.xlsx(matches, file="../output/deansRoll.xlsx", sheetName = paste("PT_matches_",  i), append=TRUE, col.names=TRUE, row.names=TRUE, showNA=TRUE)
    }
    if(length(output) > 0)
    {
      write.xlsx(output, file="../output/deansRoll.xlsx", sheetName = paste("PT_",  i), append=TRUE, col.names=TRUE, row.names=TRUE, showNA=TRUE)
    }
  }
}
########################################
#installpackages()
#installLibraries()
#setWDfunction()
########################################
##load in comapsion student set 
students = read.csv("../output/students.csv")
########################################
#lData <- file.choose()
#df <-loadData()
########################################
#lData <- file.choose()
#df <-loadData(lData)
########################################
df<- load_files_directory()
df <- createDataFrame(df)
df <- createStudentID(df)
df <- createYear(df)
df <-renameDF(df)
df$DR <- deans_roll(df)
strip_and_write(strip_files(df))
########################################