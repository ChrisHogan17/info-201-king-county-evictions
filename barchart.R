eviction_data <- read.csv("final_evictions.csv")
library(ggplot2)
library(dplyr)
library(plotly)

no_less_than_a_month <- eviction_data %>% filter(less_than_one_month == "No") %>% 
  group_by(zip_code) %>% count("less_than_one_month")

colnames(no_less_than_a_month)[colnames(no_less_than_a_month) == "n"] <- "No"

less_than_a_month <- eviction_data %>% filter(less_than_one_month == "Yes") %>% 
  group_by(zip_code) %>% count("less_than_one_month")

colnames(less_than_a_month)[colnames(less_than_a_month) == "n"] <- "Yes"

all_data <- merge(x = no_less_than_a_month, y = less_than_a_month, by = "zip_code", all = TRUE)
all_data <- all_data[-4]

all_data <- all_data %>% mutate(seq_num = (1:46))

bar_chart <- function(bar_variable) {
  if (bar_variable == "No") {
    bar_plot <- ggplot(data = all_data, aes(x = seq_num, y = No, zipcode = zip_code)) +
      geom_bar(stat = "identity", width = 0.8, fill = "steelblue") +
      geom_text(aes(label = No), vjust=1.6, color="black",
                position = position_dodge(0.6), size = 3.0) +
      xlab("Zip Code") + ylab("Number of No Less than a Month") +
      ggtitle("The Number of No Less than One Month for Each Zip Code Area")
    
    ggplotly(bar_plot, tooltip = c("zipcode"))
  } else if (bar_variable == "Yes") {
    bar_plot <- ggplot(data = all_data, aes(x = seq_num, y = Yes, zipcode = zip_code)) +
      geom_bar(stat = "identity", width = 0.8, fill = "#FF9999") +
      geom_text(aes(label = Yes), vjust=1.6, color="black",
                position = position_dodge(0.6), size = 3.0) +
      xlab("Zip Code") + ylab("Number of Less than a Month") +
      ggtitle("The Number of Less than One Month for Each Zip Code Area")
    
    ggplotly(bar_plot, tooltip = c("zipcode"))
  }
}

bar_chart("No")