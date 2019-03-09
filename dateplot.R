library(plotly)

source("./analysis.R")

# Build date plot 

date_plot <- plot_ly(
  evictions_date, 
  x = ~date, 
  y = ~city,
  type = "scatter",
  mode = "markers"
) %>% 
  layout(title = "Evictions Dates by City",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Evictions by City"))

date_plot
