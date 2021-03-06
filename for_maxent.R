# For MaxEnt 
library(raster)
library(tidyverse)

globe <- globe %>%
  mutate(measured_on = ymd(measured_on)) %>%
  select(site_id, org_name, latitude, longitude, elevation, measured_on,
         `mosquito habitat mapper:data source`,
         `mosquito habitat mapper:measured at`,
         `mosquito habitat mapper:water source type`,
         `mosquito habitat mapper:water source`,
         `mosquito habitat mapper:larvae count`,
         `mosquito habitat mapper:mosquito eggs`,
         `mosquito habitat mapper:mosquito egg count`,
         `mosquito habitat mapper:mosquito pupae`,
         `mosquito habitat mapper:mosquito adults`,
         `mosquito habitat mapper:genus`,
         `mosquito habitat mapper:species`) %>%
  mutate(site_id = as.numeric(site_id))%>%
  mutate(latitude = as.numeric(latitude))%>%
  mutate(longitude = as.numeric(longitude))%>%
  filter(`mosquito habitat mapper:data source` == "GLOBE Observer App") %>%
  filter(`mosquito habitat mapper:larvae count` < 199 | 
           `mosquito habitat mapper:mosquito pupae` == TRUE |
           `mosquito habitat mapper:mosquito eggs` == TRUE |
           `mosquito habitat mapper:mosquito adults` == TRUE ) %>%
  filter(`mosquito habitat mapper:genus` == "Aedes") %>%
  mutate(latitude = round(latitude, digits = 3)) %>%
  mutate(longitude = round(longitude, digits = 3))


globe %>%
  group_by(site_id)

maxent_aaegypti <- aedes %>%
  filter(`mosquito habitat mapper:larvae count` < 199 | 
           `mosquito habitat mapper:mosquito pupae` == TRUE |
           `mosquito habitat mapper:mosquito eggs` == TRUE |
           `mosquito habitat mapper:mosquito adults` == TRUE ) %>%
  filter(`mosquito habitat mapper:species` == "aegypti") %>%
  group_by(site_id)

write.csv(maxent_aaegypti, "maxent_aaegypti.csv")

?raster

?extent

ma.area <- extent(-30, 20, -10, 20)

bio1 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_1.tif", xmin = -30, xmax = 20,
                                                      ymin = -10, ymax = 20)
ma.bio <- crop(bio1, ma.area)

writeRaster(ma.bio, filename = "bio1.asc", format = "ascii", overwrite = TRUE)


bio2 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_2.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio2 <- crop(bio2, ma.area)

writeRaster(ma.bio2, filename = "bio2.asc", format = "ascii", overwrite = TRUE)


bio3 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_3.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio3 <- crop(bio3, ma.area)

writeRaster(ma.bio3, filename = "bio3.asc", format = "ascii", overwrite = TRUE)


bio4 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_4.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio4 <- crop(bio4, ma.area)

writeRaster(ma.bio4, filename = "bio4.asc", format = "ascii", overwrite = TRUE)


bio5 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_5.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio5 <- crop(bio5, ma.area)

writeRaster(ma.bio5, filename = "bio5.asc", format = "ascii", overwrite = TRUE)


bio6 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_6.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio6 <- crop(bio6, ma.area)

writeRaster(ma.bio6, filename = "bio6.asc", format = "ascii", overwrite = TRUE)


bio7 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_7.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio7 <- crop(bio7, ma.area)

writeRaster(ma.bio7, filename = "bio7.asc", format = "ascii", overwrite = TRUE)


bio8 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_8.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio8 <- crop(bio8, ma.area)

writeRaster(ma.bio8, filename = "bio8.asc", format = "ascii", overwrite = TRUE)


bio9 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_9.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio9 <- crop(bio9, ma.area)

writeRaster(ma.bio9, filename = "bio9.asc", format = "ascii", overwrite = TRUE)


bio10 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_10.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio10 <- crop(bio10, ma.area)

writeRaster(ma.bio10, filename = "bio10.asc", format = "ascii", overwrite = TRUE)


bio11 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_11.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio11 <- crop(bio11, ma.area)

writeRaster(ma.bio11, filename = "bio11.asc", format = "ascii", overwrite = TRUE)


bio12 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_12.tif", xmin = -30, xmax = 20,
               ymin = -10, ymax = 20)
ma.bio12 <- crop(bio12, ma.area)

writeRaster(ma.bio12, filename = "bio12.asc", format = "ascii", overwrite = TRUE)


bio13 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_13.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio13 <- crop(bio13, ma.area)

writeRaster(ma.bio13, filename = "bio13.asc", format = "ascii", overwrite = TRUE)


bio14 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_14.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio14 <- crop(bio14, ma.area)

writeRaster(ma.bio14, filename = "bio14.asc", format = "ascii", overwrite = TRUE)


bio15 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_15.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio15 <- crop(bio15, ma.area)

writeRaster(ma.bio15, filename = "bio15.asc", format = "ascii", overwrite = TRUE)


bio16 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_16.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio16 <- crop(bio16, ma.area)

writeRaster(ma.bio16, filename = "bio16.asc", format = "ascii", overwrite = TRUE)


bio17 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_17.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio17 <- crop(bio17, ma.area)

writeRaster(ma.bio17, filename = "bio17.asc", format = "ascii", overwrite = TRUE)


bio18 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_18.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio18 <- crop(bio18, ma.area)

writeRaster(ma.bio18, filename = "bio18.asc", format = "ascii", overwrite = TRUE)


bio19 <- raster("wc2.1_2.5m_bio/wc2.1_2.5m_bio_19.tif", xmin = -30, xmax = 20,
                ymin = -10, ymax = 20)
ma.bio19 <- crop(bio19, ma.area)

writeRaster(ma.bio19, filename = "bio19.asc", format = "ascii", overwrite = TRUE)



lit0918aegypti <- lit_09_18 %>%
  filter(VECTOR == "Aedes aegypti")

unique(lit0918aegypti)

lit9908aegypti <- lit_99_08 %>%
  filter(VECTOR == "Aedes aegypti") %>%
  unique()

unique(lit9908aegypti)
  

write.csv(lit0918aegypti, "lit0918aegypti.csv")

write.csv(lit9908aegypti, "lit9908aegypti.csv")

#need all together 

globe_max <- read_csv("maxent_aaegypti.csv")
lit9908aegypti <- read_csv("lit9908aegypti.csv") %>%
  rename(species = VECTOR) %>%
  rename(latitude = X) %>%
  rename(longitude = Y)
lit0918aegypti <- read_csv("lit0918aegypti.csv") %>%
  rename(species = VECTOR) %>%
  rename(latitude = X) %>%
  rename(longitude = Y)

#new lit and globe
new_globe_maxent <- full_join(globe_max, lit0918aegypti,
                              by = c("species", "latitude", "longitude"))  %>%
  unique()

write.csv(new_globe_maxent, "newlit_globe_maxent.csv")


#all lit 

all_lit_maxent <- full_join(lit9908aegypti, lit0918aegypti,
                            by = c("species", "latitude", "longitude")) %>%
  unique()

write.csv(all_lit_maxent, "all_lit_maxent.csv")

#all 3

all3_maxent <- full_join(all_lit_maxent, globe_max,
                         by = c("species", "latitude", "longitude")) %>%
  unique()

unique((all3_maxent))  

write.csv(all3_maxent, "all3_maxent.csv")
  

library(usdm)
citation("usdm")
