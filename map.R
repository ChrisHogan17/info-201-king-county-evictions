# Load necessary libraries and source necessary files

library(dplyr)
library(leaflet)
library(ggmap)

source("analysis.R")
source("apikeys.R")

# Register api key for geocode() funciton

register_google(key = google_map_key)

# Create date range for user input controls
date_values <- seq(as.Date("2017-01-01"), as.Date("2017-12-31"), by="1 day")


# Create map function, takes the dataset as the input and returns a leaflet map

create_map <- function(evictions_input, start_date, end_date){

  # Format dataset for easier mapping
  evictions_coords <- evictions_input %>%
    mutate(city = paste0(city, ", WA")) %>%
    rename("back_rent" = Amount.of.Back.Rent..n.a.if.none.)
  
  # Add dates to the formated data set
  
  coord_dates <- evictions_date %>%
    rename("date_form" = date) %>%
    select(CaseNumber, "date_form")
  
  evictions_coords <- left_join(evictions_coords, coord_dates)
  
  # Filter based on user input
  evictions_coords <- evictions_coords %>%
    filter(date_form > start_date,
           date_form < end_date)

  # Find coordinates of each city in the set
  coords <- evictions_coords %>%
    count(city) %>%
    mutate(long = 0, lat = 0)
  
  coords[, c("long", "lat")] <- geocode(coords$city)
  
  # Join coordinates to whole data set
  evictions_coords <- left_join(evictions_coords, coords)
  
  # Create map with new coordinate data
  
  color_map <- colorNumeric("YlOrRd", evictions_coords$back_rent)
  
  eviction_map <- leaflet(data = evictions_coords) %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    setView(lat = 47.4797, lng = -122.2079, zoom = 9) %>%
    addCircleMarkers(
      lat = ~lat,
      lng = ~long,
      label = ~(paste0(city,
                       ", Eviction Reason: ", eviction_reason,
                       ", Rent: ", tenant_rent,
                       ", Back Rent: ", back_rent)),
      radius = ~(tenant_rent / 100),
      color = ~color_map(back_rent),
      clusterOptions = markerClusterOptions()
    ) %>%
    addLegend(
      pal = color_map,
      values = ~back_rent,
      title = "Amount of Back Rent in USD"
    )

  return(eviction_map)
}
