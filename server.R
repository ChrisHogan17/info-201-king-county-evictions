# Load necessary libraries and source necessary files

library(dplyr)
library(ggplot2)
library(leaflet)

source("./analysis.R")
source("./map.R")
source("./dateplot.R")
source("./barchart.R")

# Start shinyServer with user's inputs

shinyServer(function(input, output) {
  output$by_month_plot <- renderPlotly({
    return(build_date_plot(evictions_date, input$cityvar))
  })
  output$backrent_chart <- renderPlotly ({
    return(bar_chart(input$yes_no))
  })
  output$map <- renderLeaflet({
    return(create_map(evictions, input$date_range[1], input$date_range[2]))
  })
})
