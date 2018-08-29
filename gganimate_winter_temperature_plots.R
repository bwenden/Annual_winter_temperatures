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
p <- ggplot(winter, aes(x,y, fill=layer)) + 
  geom_raster(interpolate=TRUE)+
  geom_polygon(data=wr,aes(x = long, y = lat,group=group),fill = NA, colour = "black") +
  theme_bw() + scale_fill_gradient2(midpoint=0, low="blue", mid="white", high="red")+
  coord_equal() + 
  labs(title = 'Year: {frame_time}') +
  transition_time(Year) +
  ease_aes('linear')

animate(p, nframes=138, fps=2, height=500,width=625)
anim_save(p, 'winter_temp_anomalies.gif)
