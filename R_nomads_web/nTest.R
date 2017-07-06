forecast.date <- as.POSIXlt(Sys.time(), tz = "UTC")
abbrev <- "waves"
forecasts <- GetClosestForecasts(abbrev = abbrev, forecast.date)