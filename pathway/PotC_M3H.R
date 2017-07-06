#################################################
#################################################
install_packages <- function()
{
  list.of.packages <- c("xlsx", "tidyverse")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
}
#################################################
install_libraries <- function()
{
  library(tidyverse)
  library(xlsx)
}
#################################################
loadData <- function(dataFile)
{
  DF = read.csv(dataFile)
  return(DF)
}
#################################################
apply_equivalence <- function(students,pathway)
{
  students$equ_codes <- pathway$unit_code_equ[match(students$unit_code, pathway$unit_code)]
  return(students)
}
#################################################
renameDF <- function(df)
{
  names(df)[names(df)=="Student.ID"] <- "student_id"
  names(df)[names(df)=="First.Given.Name"] <- "first_name"
  names(df)[names(df)=="Family.Name"] <- "surname_name"
  names(df)[names(df)=="Parent.Study.Package.Code"] <- "study_package"
  names(df)[names(df)=="Preferred.Email.Address"] <- "email_address"
  names(df)[names(df)=="Total.Enrolled.Credit.Points"] <- "Total_Enrolled"
  names(df)[names(df)=="Total.Advanced.Standing.Credit.Points"] <- "Advanced_Standing"
  names(df)[names(df)=="Total.Course.Credit.Points"] <- "Course_Points"
  names(df)[names(df)=="Total.Achieved.Credit.Points"] <- "Total_Achieved"
  names(df)[names(df)=="Study.Period"] <- "Study_Period"
  names(df)[names(df)=="Availability.Year"] <- "year"
  df <- subset(df ,select = c("student_id", "first_name", "surname_name", "study_package", "email_address","Study_Period","year", "Total_Enrolled", "Advanced_Standing", "Total_Achieved"))
  return(df)
}
################################################
################################################
setwd("C:/Users/lmcmanam/Desktop/pathway")
install_packages()
install_libraries()
###############################################
## select individual file 
#students <- load_students()
###############################################
#students <- read.csv("input/h3d.csv", header = TRUE)
students <- read.csv("input/M3H.csv", header = TRUE)
################################################
students <- renameDF(students)
################################################s
potGrads_Sem1 <- students %>% group_by(student_id) %>% filter(year == 2017, Total_Achieved >= 250, Study_Period != "Semester 2" ) %>%  select(student_id, surname_name, first_name,  Total_Enrolled, Total_Achieved, study_package)
################################################
potGrads_Sem1 <- unique(potGrads_Sem1)
potGrads_Sem1 <- potGrads_Sem1[order(potGrads_Sem1$surname_name),]
################################################
################################################
write.csv(potGrads_Sem1, file = "PotC_M3H.csv")
################################################

################################################
################################################