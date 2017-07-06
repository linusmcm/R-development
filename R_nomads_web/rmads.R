############################################################
install.packages("RgoogleMaps")
install.packages("rNOMADS")
install.packages("sp")
###########################################################
library(rNOMADS)
library(RgoogleMaps)
library(sp)
###########################################################
###########################################################
#centre four mile
lon <- 148.299273
lat <- -41.547111

urls.out <- GetDODSDates(abbrev = "gfs_0p50")
model.url <- tail(urls.out$url, 1) #Get most recent model date
variable <- "tmp2m" #temp at 2 m
time <- c(2,2) #6 hour prediction
model.urls <- GetDODSDates("gfs_0p50")
latest.model <- tail(model.urls$url, 1)
model.runs <- GetDODSModelRuns(latest.model)
latest.model.run <- tail(model.runs$model.run, 1)

#Download worldwide temperature data at 2 m
variable <- "tmp2m"
time <- c(0, 0) #Analysis run, index starts at 0
lon <- c(0, 719) #All 720 longitude points
lat <- c(0, 360) #All 361 latitude points
model.data <- DODSGrab(latest.model, latest.model.run, variable, time, lon, lat)





#south fourmile
#lat <- -41.557397);
#lon <- 148.291949;

zoom <- min(MaxZoom(range(lat), range(lon)));
GetMap(center = c(-41.557397, 148.291949),zoom=zoom +1, destfile = "Four_Mile_plus1.png")
GetMap(center = c(-41.557397, 148.291949),zoom=zoom, destfile = "Four_Mile_zero.png")
GetMap(center = c(-41.557397, 148.291949),zoom=zoom -1, destfile = "Four_Mile_minus1.png")
MyMap <- GetMap.bbox(lon, lat,destfile = "fM_Sat.png", maptype = "satellite")

MyMap <- GetMap.bbox(lon, lat, zoom=zoom, destfile = "fM_Sat.png", maptype = "satellite") 


###########################################################

#Get latest GFS 0.5 model, use analysis forecast
## Not run: 
model.url <- CrawlModels(abbrev = "gfs_0p50", depth = 1)#[1]
pred <- ParseModelPage(model.url)$pred[1]

## End(Not run)

#Get levels
pressure <- c(1, 2, 3, 5, 7,10, 20, 30, 50, 70, seq(100, 1000, by = 25))
levels <- paste(pressure, " mb", sep = "")

#Variables - temperature and height only
variables <- c("TMP", "HGT")

## Not run: 
grib.info <- GribGrab(model.url, pred, levels, variables, model.domain = c(-85, -75, 37, 32))
grib.data <- ReadGrib(grib.info$file.name, levels, variables)

profile <- BuildProfile(grib.data, lon, lat, TRUE, points = 8)
plot(profile[[1]]$profile.data[,2, 1] - 272.15, profile[[1]]$profile.data[,1, 1], xlab = "Temperature (C)", ylab = "Height (m)", main = "Temperature Profile above Chapel Hill, NC")

## End(Not run)