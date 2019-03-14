# Load necessary libraries and source necessary files

library(dplyr)
library(leaflet)
library(ggmap)

source("analysis.R")
source("apikeys.R")

# Register api key for geocode() funciton

register_google(key = google_map_key)

create_map <- function(evictions_input){

  # Create lattitude and longitude columns, then fill with coordinates
  evictions_coords <- evictions_input %>%
    mutate(city = paste0(city, ", WA")) %>%
    mutate(long = 0, lat = 0) %>%
    rename("back_rent" = Amount.of.Back.Rent..n.a.if.none.)
  
  evictions_coords[, c("long", "lat")] <- geocode(evictions_coords$city)
  
  # Create map with new coordinate data
  
  color_map <- colorQuantile("YlOrRd", evictions_coords$back_rent)
  
  eviction_map <- leaflet(data = evictions_coords) %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    setView(lat = 47.4797, lng = -122.2079, zoom = 9) %>%
    addCircleMarkers(
      lat = ~lat,
      lng = ~long,
      label = ~(paste0(city, ", Eviction Reason: ", eviction_reason)),
      radius = ~(tenant_rent / 100),
      color = ~color_map(back_rent),
      clusterOptions = markerClusterOptions()
    ) %>%
    addLegend(pal = color_map, values = ~back_rent)

  return(eviction_map)
}