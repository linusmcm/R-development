############################################################
############################################################
install.packages("ncdf4")
install.packages("googleVis")
install.packages("reshape")
install.packages("scales")
library(googleVis)
library(reshape)
library(scales)
require(data.table)




DF<- open.nc("surface.nc4", write=FALSE, share=FALSE, prefill=TRUE)
ncdata <- nc_open('surface.nc4')
print(ncdata)
ncdata
############################################################
#mean Direction of primary swell
### grid_type: spatial
###level_type: single
###units: deg_true
mp_swell_dir <- ncvar_get(ncdata, 'mn_dir_sw1')
############################################################
#wind speed
#float wnd_spd[lon,lat,time]   
#grid_type: spatial
#level_type: single
#units: m s-1
#long_name: Wind Speed
wind_Speed <- ncvar_get(ncdata, 'wnd_spd')
############################################################
#wind direction
#wnd_dir[lon,lat,time]   
#grid_type: spatial
#level_type: single
#units: deg_true
#long_name: Wind Direction
wind_direction <- ncvar_get(ncdata, 'wnd_dir')
############################################################
#float sig_wav_ht[lon,lat,time]   
#grid_type: spatial
#level_type: single
#units: m
#long_name: Significant Wave Height
signif_wave_height <- ncvar_get(ncdata, 'sig_wav_ht')
############################################################
time <- ncvar_get(ncdata, 'time')
pk <- ncvar_get(ncdata, 'pk_wav_dir')
pk_wav_dir5  b 
length(time)
lat <- ncvar_get(ncdata, 'lat')
lon <- ncvar_get(ncdata, 'lon')
LatLong <- paste(lat,lon, sep = ":")
df <- data.frame(LatLong, mean_primary_swell_direction)
testMap <- gvisMap(df, "LatLong")
plot(testMap)
melt(a)
swell_Dir_Lon <- melt(mp_swell_dir[, 1:721])
swell_Dir_Lat <- melt(mp_swell_dir[1:1111])
df <- data.frame(swell_Dir_Lat, swell_Dir_Lon)