#################################################
#################################################
install_packages <- function()
{
  install.packages("xlsx")
  install.packages("tidyverse")
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
if_function <- function()
{
  students$equlivance <- with(students, ifelse(unit_code == "CNA116","CNA149", ifelse(unit_code == "CNA110","CNA150", ifelse(unit_code == "HGA138","CNA156/157", ""))))
}

#################################################
loadData <- function(dataFile)
{
  df <- read.xlsx2(dataFile, 1)  
  return(df)
}
#################################################
apply_equivalence <- function(students,pathway)
{
  students$equ_codes <- pathway$unit_code_equ[match(students$unit_code, pathway$unit_code)]
  return(students)
}
#################################################
currentPathway <- function()
{

  
}
#################################################
renameDF <- function(df)
{
  names(df)[names(df)=="Study.Package.Code"] <- "unit_code"
  names(df)[names(df)=="Study.Package.Full.Title"] <- "unit_name"
  names(df)[names(df)=="Student.Study.Package.Status" ] <- "unit_grade"
  names(df)[names(df)=="Grade.Code"] <- "grade_code"
  names(df)[names(df)=="Mark"] <- "mark"
  names(df)[names(df)=="Student.ID"] <- "student_id"
  names(df)[names(df)=="First.Given.Name"] <- "first_name"
  names(df)[names(df)=="Family.Name"] <- "surname_name"
  names(df)[names(df)=="Availability.Year"] <- "year"
  names(df)[names(df)=="Location"] <- "location"
  names(df)[names(df)=="Study.Period"] <- "study_period"
  names(df)[names(df)=="Study.Package.CP.Value"] <- "cp_value"
  names(df)[names(df)=="Parent.Study.Package.Code"] <- "study_package"
  names(df)[names(df)=="Preferred.Email.Address"] <- "email_address"
  df <- subset(df ,select = c("student_id", "mark", "grade_code", "unit_code", "unit_name", "unit_grade", "location", "year", "study_period", "cp_value", "study_package", "first_name", "surname_name", "email_address" ))
  return(df)
}
################################################
################################################
setwd("C:/Users/lmcmanam/Desktop/pathway")
pathway = read.csv("unitcodes.csv", header = TRUE)
old_units = read.csv("oldUnits.csv", header = TRUE)
H3D_pathway = read.csv("H3D_pathway.csv", header = TRUE)
students <- load_students()
################################################
#install_packages()
#install_libraries()
################################################
################################################
ldata <- file.choose()
students <-loadData(ldata)
################################################
students <- renameDF(students)
ID <- unique(students$student_id)
################################################
students <- apply_equivalence(students, pathway)
unitcodes <- H3D_pathway$unit_code
################################################
################################################
write.csv(students, file = "students.csv")


################################################
################################################


#new_unitcodes <- append(unitcodes, "student_id", after = 0)
#studentMatrix <- data.frame(ID,unitCodes = as.list(unitcodes))
#studentMatrix <- data.frame(student_id = ID, unitCodes = as.list(unitcodes))

#names(studentMatrix)<- unitcodes
#setnames(DF, nms)

################################################
################################################
colnames(studentMatrix) <- unitcodes

for(i in unique(students$student_id))
{
  
  
}
################################################
################################################
################################################
spare_code <- function()
{

  for(i in unique(students$Student.ID))
  {
    output <- students %>%  filter(Student.ID == i) %>% select(Student.ID,unit_code,unit_name,unit_grade,grade_code,mark)
    #write.xlsx(output, file="output/test6.xlsx", sheetName = paste(i), append=TRUE, col.names=TRUE, row.names=TRUE, showNA=TRUE)
  }

}
################################################
################################################
################################################

x[x != unitcodes]

