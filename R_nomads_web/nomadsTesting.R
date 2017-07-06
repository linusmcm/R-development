install.packages("animation")
install.packages("googleVis")
install.packages(c("devtools","RJSONIO", "knitr", "shiny", "httpuv"))
install.packages("RgoogleMaps")
install.packages("rNOMADS")
install.packages("sp")
###########################################################
############################################################
library(rNOMADS)
library(RgoogleMaps)
library(sp)
library(animation)
library(googleVis)
library(devtools)
library(RJSONIO)
library(knitr)
library(shiny)
library(httpuv)



###########################################################
###########################################################
#Global variables
waveURL_DODS <<- "http://nomads.ncep.noaa.gov:9090/dods/wave/mww3/"
###########################################################
###########################################################
today_datum <- function()
{
  today <- Sys.Date()
  datum <-format(today, format="%Y %m %d")
  return(gsub(" ", "", datum)) 
}
###########################################################
createWaveModelString <- function(url, datm)
{
  textString <- paste(url,datm, sep = "")
  return(textString)
}
###########################################################
###########################################################
###########################################################
#model.urls <- GetDODSDates("wave")
datum <- today_datum()
waveURL_String <- createWaveModelString(waveURL_DODS, datum)
latest.model <- waveURL_String
model.runs <- GetDODSModelRuns(latest.model)
latest.model.run <- tail(model.runs$model.run, 2)






variable <-  "perpwsfc"
time <- c(0, 0) #Analysis run, index starts at 0
#lon <- c(0, 719) #All 720 longitude points
#lat <- c(0, 360) #All 361 latitude points
lon <- (0, 358.75)
lat <- (-78.0 , 78.0)
model.data <- DODSGrab(latest.model, latest.model.run, variable, time, lon, lat)
model.data <- DODSGrab(waveURL_String , model.runs , variable, time, lon, lat)
###########################################################
###########################################################
###########################################################

urls.out <- GetDODSDates(abbrev = "gfs_0p50")
model.url <- tail(urls.out$url, 1) #Get most recent model date
variable <- "tmp2m" #temp at 2 m
time <- c(2,2) #6 hour prediction
model.urls <- GetDODSDates("gfs_0p50")
latest.model <- tail(model.urls$url, 1)
model.runs <- GetDODSModelRuns(latest.model)
latest.model.run <- tail(model.runs$model.run, 1)

#Download worldwide temperature data at 2 m
variable <- "perpwsfc"
time <- c(0, 0) #Analysis run, index starts at 0
lon <- c(0, 719) #All 720 longitude points
lat <- c(0, 360) #All 361 latitude points
model.data <- DODSGrab(latest.model, model.runs$model.run[6], variable, time, lon, lat)

###########################################################
###########################################################
###########################################################


latest.model <- tail(model.urls$url, 1)
#latest.model <- model.urls$url
# mustr come back an work out string manipulation
latest.model <- "http://nomads.ncep.noaa.gov:9090/dods/wave/mww3/20160818"
#model.runs <- GetDODSModelRuns(latest.model)
model.runs <- GetDODSModelRunInfo(model.urls, model.runs)
latest.model.run <- tail(model.runs$model.run, 1)
#Download worldwide temperature data at 2 m
#variable <- "tmp2m"
#variable <- "no5wavh500mb"
#variable <-  "tmpsfc"
variable <-  "perpwsfc"
time <- c(0, 0) #Analysis run, index starts at 0
#lon <- c(0, 719) #All 720 longitude points
#lat <- c(0, 360) #All 361 latitude points
Lon <- (0, 358.75)
Lat <- (-78.0 , 78.0)
model.data <- DODSGrab(latest.model, latest.model.run, variable, time, lon, lat)

url <- "http://nomads.ncep.noaa.gov:9090/dods/wave/"
test <- WebCrawler(url, depth = NULL, verbose = TRUE)
ParseModelPage(url)

sp_lon <- 148.299273
sp_lat <- -41.547111
profile <- BuildProfile(model.data, sp_lon, sp_lat, spatial.average = TRUE, points = 4)


##########################################################
localAddress <- "Four mile creek Tasmania"
AndrewMap <- gvisMap(localAddress, "LatLong" , "Tip", options=list(showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE, mapType='terrain', useMapTypeControl=TRUE))
plot(AndrewMap)

##########################################################
gvisMap(data, locationvar = "", tipvar = "", options = list(), chartid)
testMap <- gvisMap(Andrew, locationvar = "Four mile creek Tasmania", options = (mapType='terrain'))
plot(testMap)
##########################################################

Cal <- gvisCalendar(Cairo, datevar="Date", numvar="Temp", options=list( title="Daily temperature in Cairo", height=320, calendar="{yearLabel: { fontName: 'Times-Roman', fontSize: 32, color: '#1A8763', bold: true},cellSize: 10,cellColor: { stroke: 'red', strokeOpacity: 0.2 },focusedCellColor: {stroke:'red'}}"))
plot(Cal)
##########################################################
Timeline <- gvisTimeline(data=datTL, rowlabel="Name", barlabel="Position", start="start", end="end",options=list(timeline="{groupByRowLabel:false}", backgroundColor='#ffd', height=350, colors="['#cbb69d', '#603913', '#c69c6e']"))
plot(Timeline)
##########################################################

AndrewGeo <- gvisGeoMap(Andrew, locationvar="LatLong", numvar="Speed_kt", hovervar="Category", options=list(height=350, region="US", dataMode="markers"))
plot(AndrewGeo)
##########################################################

Long <- 148.299273
Lat <- -41.547111
LatLong <- c(-41.547111, 148.299273)
Tip <- "Four mile creek Tasmania"
locationvar <- "Four mile creek Tasmania"
DF <- data.frame(LatLong, Tip, locationvar)
testMap <- gvisMap(DF, "LatLong", "Tip", options=list(showTip=TRUE, mapType='normal',  enableScrollWheel=TRUE))
plot(testMap)



AndrewGeo <- gvisGeoMap(Andrew, 
                        locationvar="LatLong", 
                        numvar="Speed_kt", 
                        hovervar="Category", 
                        options=list(height=350, 
                                     region=, 
                                     dataMode="markers"))
plot(AndrewGeo)
