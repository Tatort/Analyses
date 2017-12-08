###### creating a map of my study area using ggmap

#load packages
library(dplyr)
library(ggmap)
library(rgdal)
library(raster)

## read in data

island <- read.csv("data/island_data_10_30_2017.csv")

## inspect data

head(island)
str(island)

# converting csv data

points_crs <- crs("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
points_spat <- SpatialPointsDataFrame(
  island [c('lon', 'lat')], 
  island, 
  proj4string = points_crs)

# check structure of new spatial data
str(points_spat)
str(points_crs)

# plot points

plot(points_spat)

# get study area for map

avg_long = mean(island$lon)
avg_lat = mean(island$lat)

# get map

map = get_map(location = c(lon = avg_long, lat = avg_lat), zoom = 11, maptype = "watercolor")
plot(map)

## plot island (csv) points to map

ggmap(map, extent = "device") +
  geom_point(data = island, aes(x = lon , y = lat))

## try dif point size

ggmap(map, extent = "device") +
  geom_point(data = island, aes(x = lon , y = lat), size = 2)

## create new df
island <- data.frame(island, Legend = "sampled Islands")

### added legend with new color = and used scale_color_manual to turn points blk
ggmap(map, extent = "device") +
  geom_point(data = island, aes(x = lon , y = lat, color = Legend), size = 2) +
  scale_color_manual(values = "black")

## changed names to better reflect map needs. type = Legend and sample locations = sampled islands

## change legend location
ggmap(map, extent = "device", legend = "bottomleft") +
  geom_point(data = island, aes(x = lon , y = lat, color = Legend), size = 2) +
  scale_color_manual(values = "black")

# changed size of points

ggmap(map, extent = "device", legend = "bottomleft") +
  geom_point(data = island, aes(x = lon , y = lat, color = Legend), size = 1.75) +
  scale_color_manual(values = "black")

## maptype = watercolor too fancy? explore different maptypes

# maptype = "terrain" 
map2 = get_map(location = c(lon = avg_long, lat = avg_lat), zoom = 11, maptype = "terrain")
plot(map2)

# maptype = "terrain-background"

map3 = get_map(location = c(lon = avg_long, lat = avg_lat), zoom = 11, maptype = "terrain-background")
plot(map3)

# maptype = "toner"

map4 = get_map(location = c(lon = avg_long, lat = avg_lat), zoom = 11, maptype = "toner")
plot(map4)

##### save map

site_map <- ggmap(map, extent = "device", legend = "bottomleft") +
  geom_point(data = island, aes(x = lon , y = lat, color = Legend), size = 1.75) +
  scale_color_manual(values = "black")

ggsave(filename = "map_island.jpeg", plot = site_map, width = 8, height = 6, dpi = 300) 

###### Create another map of crab trap experiment area

crabs <- read.csv("data/crab_sample.csv")

# convert points 
points_crs3 <- crs("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
points_spat3 <- SpatialPointsDataFrame(
  crabs [c('lon', 'lat')], 
  crabs, 
  proj4string = points_crs3)

plot(points_spat3)
str(points_crs3)

##### get mean points for map
avg_long = mean(crabs$lon)
avg_lat = mean(crabs$lat)

### get map

map6 = get_map(location = c(lon = avg_long, lat = avg_lat), zoom = 11, maptype = "watercolor")
plot(map6)

# change shape of point
crab_map <- ggmap(map6, extent = "device", legend = "bottomleft") +
  geom_point(data = crabs, aes(x = lon , y = lat), size = 3.75, shape = 24, fill = "black") 
  

### save map

ggsave(filename = "map_crab.jpeg", plot = crab_map, width = 8, height = 6, dpi = 300) 





