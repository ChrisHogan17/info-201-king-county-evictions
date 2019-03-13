library(dplyr)
library(ggplot2)

source('./analysis.R')

# Start shinyServer
shinyServer(function(input, output) { 
  output$by_month_plot <- renderPlotly({
    return(build_date_plot(evictions_date, input$cityvar))
  })
  output$backrent_chart <- renderPlotly ({
    return(bar_chart(input$yes_no))
  })
})
