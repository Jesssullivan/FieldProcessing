# KML search tool and CSV converter
# Note GDAL with EXPAT is required
# Toolset:
library(rgdal)
library(plyr)
#library(gdalUtils)
#set home dir
setwd("~/")
#vectors !for ui!
keyword1 <- "pair"
keyword2 <- "fem"
destfile <- "finishedCSV.csv"
kmlfile <- "Input.kml"
# find layers to extract in table 
kml_layers <- ogrListLayers(kmlfile)
it <- as.numeric(length(kml_layers))
# func to deal with multiple layers
i <- 1
func <- function(i){
  da <-  readOGR(kmlfile, layer = kml_layers[i])
  i <- i+1
  return(da)
}
# apply func and form table 
dat <- lapply(i:it, func)
data <- ldply(dat, data.frame)
### Optional write from here
# write.csv(data, alt.destfile)
### Search Function:
kw1 <- contains(keyword1, vars = data$Description)
kw2 <- contains(keyword2, vars = data$Description)
# combine resulting matches as numbers
result <- combine(kw1, kw2)
# find entry matches
results <- data.frame(data[result,])
#write.csv(results, destfile)