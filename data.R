library(tidyverse)
library(lubridate)

##################################################
###            Cleaning data                   ###
###   Download .csv files before running       ###         
##################################################

#read in raw data .csv

globe <- read_csv("GLOBEMeasurementData-14852.csv") %>%
  slice(-1)

lit_09_18 <- read_csv("Aedes mosquitoes 2009 - 2018.csv")

lit_99_08 <- read_csv("Aedes mosquitoes 1999-2008.csv")

#cleaning for use 

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
  filter(`mosquito habitat mapper:larvae count` < 1999 | 
           `mosquito habitat mapper:larvae count` > 0 | 
           `mosquito habitat mapper:mosquito pupae` == TRUE |
           `mosquito habitat mapper:mosquito eggs` == TRUE |
           `mosquito habitat mapper:mosquito adults` == TRUE ) %>%
  filter(`mosquito habitat mapper:genus` == "Aedes") %>%
  mutate(latitude = round(latitude, digits = 3)) %>%
  mutate(longitude = round(longitude, digits = 3))

# Creating datasets with countries included 

#code adapted from https://stackoverflow.com/questions/14334970/convert-latitude-and-longitude-coordinates-to-country-name-in-r

library(sp)
library(rworldmap)

# The single argument to this function, points, is a data.frame in which:
#   - column 1 contains the longitude in degrees
#   - column 2 contains the latitude in degrees
coords2country = function(points)
{  
  countriesSP <- getMap(resolution='low')
  #countriesSP <- getMap(resolution='high') #you could use high res map from rworldxtra if you were concerned about detail
  
  # convert our list of points to a SpatialPoints object
  
  # pointsSP = SpatialPoints(points, proj4string=CRS(" +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"))
  
  #setting CRS directly to that from rworldmap
  pointsSP = SpatialPoints(points, proj4string=CRS(proj4string(countriesSP)))  
  
  
  # use 'over' to get indices of the Polygons object containing each point 
  indices = over(pointsSP, countriesSP)
  
  # return the ADMIN names of each country
  indices$ADMIN  
  #indices$ISO3 # returns the ISO3 code 
  #indices$continent   # returns the continent (6 continent model)
  #indices$REGION   # returns the continent (7 continent model)
}

points <- read_csv("Book2.csv") %>%
  select(1:2)

long_lat <- globe %>%
  select(c(`longitude`,
           `latitude`))

countries <- tibble(site_id = globe$site_id, 
                    latitude = globe$latitude,
                    longitude = globe$longitude,
                    country = (coords2country(long_lat)),
                    present = TRUE) %>%
  mutate(latlong = paste(latitude, longitude, sep = ","))

globe_country <- inner_join(countries, globe, by = "site_id") %>%
  mutate(elevation = as.numeric(elevation)) %>%
  mutate(org_name = as.factor(org_name)) %>%
  rename(genus = `mosquito habitat mapper:genus`) %>%
  mutate(genus = as.factor(genus)) %>%
  rename(species = `mosquito habitat mapper:species`) %>%
  mutate(species = as.factor(species)) %>%
  rename(source = `mosquito habitat mapper:water source type`) %>%
  mutate(source = as.factor(source))
globe_country <- unique(globe_country)

write_csv(globe, "globe_aedes.csv")

#cleaning globe for maxent presence observations 

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

#cleaning literature data

lit_09_18 <- lit_09_18 %>%
  select(COUNTRY, VECTOR, OCCURRENCE_ID) %>%
  mutate(source = "09-18")

lit_99_08 <- lit_99_08 %>%
  select(COUNTRY, VECTOR, OCCURRENCE_ID) %>%
  mutate(source = "99-08")


both_lit <- full_join(lit_09_18, lit_99_08, by = c("COUNTRY", "VECTOR", "source",
                                                   "OCCURRENCE_ID"))
#combining datasets

g2 <- globe_country %>%
  select(species, country) %>%
  mutate(source = "GLOBE MHM") %>%
  rename(VECTOR = species) %>%
  rename(COUNTRY = country)

globe_newlit <- full_join(g2, lit_09_18, by = c("COUNTRY", "VECTOR", "source"))




  