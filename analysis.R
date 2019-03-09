library(dplyr)

evictions <- read.csv("evictions.csv", stringsAsFactors = F)

# Plot by date analysis

evictions_date <- evictions %>% 
  mutate(in_date_form = as.Date(date, "%m/%d/%y")) %>% 
  select(CaseNumber, city, in_date_form) %>% 
  rename("date" = in_date_form)
