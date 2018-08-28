library(tidyverse)
library(viridis)
library(gganimate)

winter <- read.csv2("winter.csv") #Import annual winter temperatures 188-2018, data from http://worldclim.org/version2
wr <- map_data("world") #World map

##Mean winter temperature
wrmap <- ggplot(winter, aes(x,y, fill=layer)) + 
  geom_raster()+
  geom_polygon(data=wr,aes(x = long, y = lat,group=group),fill = NA, colour = "black") +
  theme_bw() + 
  coord_equal()
plot(wrmap)

###Animated plots with mean annual winter temperatures 1880-2017
ggplot(winter, aes(x,y, fill=layer)) + 
  geom_raster(interpolate=TRUE)+
  geom_polygon(data=wr,aes(x = long, y = lat,group=group),fill = NA, colour = "black") +
  theme_bw() + scale_fill_viridis(option="magma")+
  coord_equal() + 
  labs(title = 'Year: {frame_time}') +
  transition_time(Year) +
  ease_aes('linear')

ggplot(winter, aes(x,y, fill=layer)) + 
  geom_raster(interpolate=TRUE)+
  geom_polygon(data=wr,aes(x = long, y = lat,group=group),fill = NA, colour = "black") +
  theme_bw() + scale_fill_viridis(option="magma")+
  coord_equal() + 
  labs(title = 'Year: {closest_state}') +
  transition_states(Year, transition_length=1, state_length=3) +
  ease_aes('linear')