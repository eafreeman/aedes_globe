library(dismo) # interface with MaxEnt
library(raster) # spatial data manipulation
library(MASS) # for 2D kernel density function
library(magrittr) # for piping functionality, i.e., %>%
library(maptools) # reading shapefiles
library(tidyverse)
library(usdm)
##################################################
### to begin: run all of data, VIF,           ###
### and for_maxent scripts first              ###         
################################################

#Using all Aedes data from all data sources

globe <- globe %>%
  rename(OCCURRENCE_ID = site_id) %>%
  rename(X = latitude) %>%
  rename(Y = longitude) %>%
  mutate(X = as.double(X)) %>%
  mutate(Y = as.double(Y)) %>%
  mutate(OCCURRENCE_ID = as.double(OCCURRENCE_ID))

two <- full_join(globe, lit_09_18, by = c("X", "Y", "OCCURRENCE_ID"))


all_aedes <- full_join(two, lit_99_08, by = c("X", "Y", "OCCURRENCE_ID"))


climdat <- brick(ma.bio) #set climate data

locations <- all_aedes %>% #set presence location data
  dplyr::select(X, Y)

occur.ras <- rasterize(locations, climdat, 1)

plot(occur.ras)

presences <- which(values(occur.ras) == 1)
pres.locs <- coordinates(occur.ras)[presences, ]

dens <- kde2d(pres.locs[,1], pres.locs[,2], n = c(nrow(occur.ras), ncol(occur.ras)))
dens.ras <- raster(dens, extent(ma.area))
plot(dens.ras)

dens.ras <- extend(dens.ras, ma.area) #resize raster to full extent

plot(dens.ras)

dens.work <- resample(dens.ras, ma.bio) #also resize raster

plot(dens.work)

writeRaster(dens.work, filename = "bias_all_aedes.asc", format = "ascii", overwrite = TRUE)

