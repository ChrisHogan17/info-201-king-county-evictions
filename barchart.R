# Load necessary libraries and source necessary files

library(ggplot2)
library(dplyr)
library(plotly)

source("./analysis.R")

# Create function for making the bar chart

bar_chart <- function(bar_variable) {
  if (bar_variable == "No") {
    bar_plot <- ggplot(data = all_data, aes(x = city, y = No,
                                            the_city = city)) +
      geom_bar(stat = "identity", width = 0.8, fill = "steelblue") +
      geom_text(aes(label = No), vjust = 1.6, color = "black",
                position = position_dodge(0.6), size = 3.0) +
      theme(axis.text.x = element_text(angle = -90, vjust = 0)) +
      xlab("City") + ylab("Number of Cases") +
      ggtitle(
        "The Number of Cases Where Tenant Owes Greater Than One Month Rent"
      )
   
    ggplotly(bar_plot, tooltip = c("the_city"))
  } else if (bar_variable == "Yes") {
    bar_plot <- ggplot(data = all_data, aes(x = city, y = Yes,
                                            the_city = city)) +
      geom_bar(stat = "identity", width = 0.8, fill = "#FF9999") +
      geom_text(aes(label = Yes), vjust = 1.6, color = "black",
                position = position_dodge(0.6), size = 3.0) +
      theme(axis.text.x = element_text(angle = -90, vjust = 0)) +
      xlab("City") + ylab("Number of Cases") +
      ggtitle("The Number of Cases Where Tenant Owes Less Than One Month Rent")

    ggplotly(bar_plot, tooltip = c("the_city"))
  }
}
