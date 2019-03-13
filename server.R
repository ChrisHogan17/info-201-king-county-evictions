library(dplyr)
library(ggplot2)

source('./analysis.R')

# Start shinyServer
shinyServer(function(input, output) { 
  output$by_month_plot <- renderPlotly({
    return(build_date_plot(evictions_date,input$city_var))
  })
})
