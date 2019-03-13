library(plotly)
library(dplyr)
source("./analysis.R")

# plot function

build_date_plot <- function(big_data, city_name) {
  data <- big_data %>% 
    filter(city == city_name) %>% 
    mutate(month = format(date, "%m"))
  
  month_data <- data.frame(month = "", cases = "", stringsAsFactors = F)
  
  get_month_total <- function(data, monthvar) {
    data <- data %>% 
      filter(month == monthvar)
    cases <- nrow(data)
    month_data <- rbind(month_data, c(monthvar, cases))
    month_data
  }
  
  month_data <- get_month_total(data, "01")
  month_data <- get_month_total(data, "02")
  month_data <- get_month_total(data, "03")
  month_data <- get_month_total(data, "04")
  month_data <- get_month_total(data, "05")
  month_data <- get_month_total(data, "06")
  month_data <- get_month_total(data, "07")
  month_data <- get_month_total(data, "08")
  month_data <- get_month_total(data, "09")
  month_data <- get_month_total(data, "10")
  month_data <- get_month_total(data, "11")
  month_data <- get_month_total(data, "12")
  
  month_data$cases <- as.numeric(month_data$cases)
  
  
  
  date_plot <- plot_ly(
    month_data,
    x = ~month, 
    y = ~cases,
    type = "scatter",
    mode = "lines+markers"
  ) %>% 
    layout(title = "Monthly Evictions by City",
           xaxis = list(title = "Month"),
           yaxis = list(title = "Number of Cases"))
}

