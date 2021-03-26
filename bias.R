library(dismo) # interface with MaxEnt
library(raster) # spatial data manipulation
library(MASS) # for 2D kernel density function
library(magrittr) # for piping functionality, i.e., %>%
library(maptools) # reading shapefiles
library(tidyverse)

##################################################
### to begin: run all of data, VIF,           ###
### and for_maxent scripts first              ###         
################################################

#Old lit bias file 

old_lit <- lit_99_08 %>% #clean down to Aedes aegypti
  filter(VECTOR == "Aedes aegypti")
  
climdat <- brick(ma.bio) #set climate data

locations <- old_lit %>% #set presence location data
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

writeRaster(dens.work, filename = "bias_oldlit.asc", format = "ascii", overwrite = TRUE)

#GLOBE bias file 

globe_aeg <- globe %>%
  filter(`mosquito habitat mapper:species` == "aegypti")

climdat <- brick(ma.bio)

locations1 <- globe_aeg %>%
  dplyr::select(longitude, latitude)

occur.ras1 <- rasterize(locations1, climdat, 1)

plot(occur.ras1)

presences1 <- which(values(occur.ras1) == 1)
pres.locs1 <- coordinates(occur.ras1)[presences1, ]

dens1 <- kde2d(pres.locs1[,1], pres.locs1[,2], n = c(nrow(occur.ras1), ncol(occur.ras1)))
dens.ras1 <- raster(dens1)
plot(dens.ras1)

dens.ras1 <- extend(dens.ras1, ma.area)

plot(dens.ras1)

dens.work1 <- resample(dens.ras1, ma.bio)

plot(dens.work1)

writeRaster(dens.work1, filename = "bias_globe.asc", format = "ascii", overwrite = TRUE)

#New lit bias file 

new_lit <- lit_09_18 %>%
  filter(VECTOR == "Aedes aegypti")

climdat <- brick(ma.bio)

locations2 <- new_lit %>%
  dplyr::select(X, Y)

occur.ras2 <- rasterize(locations2, climdat, 1)

plot(occur.ras2)

presences2 <- which(values(occur.ras2) == 1)
pres.locs2 <- coordinates(occur.ras2)[presences2, ]

dens2 <- kde2d(pres.locs2[,1], pres.locs2[,2], n = c(nrow(occur.ras2), ncol(occur.ras2)))
dens.ras2 <- raster(dens2)
plot(dens.ras2)

dens.ras2 <- extend(dens.ras2, ma.area)

plot(dens.ras2)

dens.work2 <- resample(dens.ras2, ma.bio)

plot(dens.work2)

writeRaster(dens.work2, filename = "bias_newlit.asc", format = "ascii", overwrite = TRUE)


