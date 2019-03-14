library(dplyr)
library(plotly)

evictions <- read.csv("evictions.csv", stringsAsFactors = F)

# Plot by date analysis

evictions_date <- evictions %>% 
  mutate(in_date_form = as.Date(date, "%m/%d/%y")) %>% 
  select(CaseNumber, city, in_date_form) %>% 
  rename("date" = in_date_form)

# List of City Options

cities <- evictions %>% 
  count(city) %>% 
  select(city) 

cities <- as.character(cities$city)

# Bar chart analysis

no_less_than_a_month <- evictions %>% filter(less_than_one_month == "No") %>% 
  group_by(city) %>% count("less_than_one_month")

colnames(no_less_than_a_month)[colnames(no_less_than_a_month) == "n"] <- "No"

less_than_a_month <- evictions %>% filter(less_than_one_month == "Yes") %>% 
  group_by(city) %>% count("less_than_one_month")

colnames(less_than_a_month)[colnames(less_than_a_month) == "n"] <- "Yes"

all_data <- merge(x = no_less_than_a_month, y = less_than_a_month, by = "city", all = TRUE)
all_data <- all_data[-4]

all_data <- all_data %>% 
  arrange(No) %>% 
  slice(1:17)

all_data$city <- as.character(all_data$city)

# Get average back rent by city
backrent <- evictions %>% 
  arrange(-Amount.of.Back.Rent..n.a.if.none.) %>% 
  slice(1:1263) %>% 
  group_by(city) %>% 
  summarise(mean(Amount.of.Back.Rent..n.a.if.none.))
