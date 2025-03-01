
#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)
library(readxl)
library(readr)
library(hms)


#### Read data ####
bus_delay_2024 <- read.csv("ttc_data/bus-data.csv")
streetcar_delay_2024 <- read.csv("ttc_data/streetcar-data.csv")
subway_delay_2024 <- read.csv("ttc_data/subway-data.csv")
subway_delay_code <- read.csv("ttc_data/subway-delay-codes.csv")

#### Clean data ####
###Delay Data ###
ttc_bus_delay <-
  bus_delay_2024 |>
  janitor::clean_names() |>  
  mutate(date = dmy(date))|>
  select(date, route, time, day, location, incident, min_delay, min_gap, direction)

ttc_streetcar_delay <-
  streetcar_delay_2024 |>
  janitor::clean_names() |>
  mutate(date = dmy(date))|>
  select(date, line, time, day, location, incident, min_delay, min_gap, bound)

ttc_subway_delay <-
  subway_delay_2024 |>
  janitor::clean_names() |>
  mutate(date = ymd(date))|>
  select(date, time, day, station, code, min_delay, min_gap, bound, line)


# ### Subway Delay Code ###
# #select proper codes
# subway_delay_code <- subway_delay_code |>
#   janitor::clean_names() |>
#   select(2, 3, 6, 7)
# 
# #take non-null values of srt_rmenu_code and create a partial dataset
# part_data <- subway_delay_code |>
#   filter(!is.na(subway_delay_code[[3]]), !is.na(subway_delay_code[[4]])) %>%
#   select(3, 4) |>
#   rename(sub_rmenu_code = colnames(subway_delay_code)[3],
#          code_description_3 = colnames(subway_delay_code)[4])
# 
# #select sub_rmenu_code
# subway_delay_code <- subway_delay_code |>
#   select(1, 2) |> rename(code = sub_rmenu_code, code_description = code_description_3)
# 
# #combined two code set
ttc_subway_delay_code <- subway_delay_code


### Filter Dataset for weekday and weekend ###

## Weekday vs Weekend Delay
ttc_bus_delay <- ttc_bus_delay |>
  mutate(day_type = ifelse(day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 
                           "Weekday", "Weekend"))
ttc_streetcar_delay <- ttc_streetcar_delay |>
  mutate(day_type = ifelse(day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 
                           "Weekday", "Weekend"))
ttc_subway_delay <- ttc_subway_delay |>
  mutate(day_type = ifelse(day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 
                           "Weekday", "Weekend"))

### Filter Dataset for rush-Hour Delay
# Bus
ttc_bus_delay <- ttc_bus_delay |>
  mutate(
    time = as_hms(paste0(time, ":00")),  # Convert 'time' to HH:MM:SS format
    rush_type = case_when(
      time >= as_hms("06:00:00") & time <= as_hms("09:00:00") ~ "morning",  # Morning rush (06:00–09:00)
      time >= as_hms("15:00:00") & time <= as_hms("19:00:00") ~ "evening",  # Evening rush (15:00–19:00)
      TRUE ~ "none"  # Not in rush hours
    )
  )

# Streetcar
ttc_streetcar_delay <- ttc_streetcar_delay |>
  mutate(
    time = as_hms(paste0(time, ":00")),  # Convert 'time' to HH:MM:SS format
    rush_type = case_when(
      time >= as_hms("06:00:00") & time <= as_hms("09:00:00") ~ "morning",  # Morning rush (06:00–09:00)
      time >= as_hms("15:00:00") & time <= as_hms("19:00:00") ~ "evening",  # Evening rush (15:00–19:00)
      TRUE ~ "none"  # Not in rush hours
    )
  )

# Subway
ttc_subway_delay <- ttc_subway_delay |>
  mutate(
    time = as_hms(paste0(time, ":00")),  # Convert 'time' to HH:MM:SS format
    rush_type = case_when(
      time >= as_hms("06:00:00") & time <= as_hms("09:00:00") ~ "morning",  # Morning rush (06:00–09:00)
      time >= as_hms("15:00:00") & time <= as_hms("19:00:00") ~ "evening",  # Evening rush (15:00–19:00)
      TRUE ~ "none"  # Not in rush hours
    )
  )

### Filter Dataset for seasons ###
#### Bus
ttc_bus_delay <- ttc_bus_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),  # Ensure the 'date' is in Date format
    season = case_when(
      month(date) %in% c(3, 4, 5) ~ "Spring",    # March, April, May
      month(date) %in% c(6, 7, 8) ~ "Summer",    # June, July, August
      month(date) %in% c(9, 10, 11) ~ "Fall",    # September, October, November
      month(date) %in% c(12, 1, 2) ~ "Winter",   # December, January, February
      TRUE ~ "Unknown"  # In case there are any issues
    )
  )

#### Streetcar
ttc_streetcar_delay <- ttc_streetcar_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),
    season = case_when(
      month(date) %in% c(3, 4, 5) ~ "Spring",
      month(date) %in% c(6, 7, 8) ~ "Summer",
      month(date) %in% c(9, 10, 11) ~ "Fall",
      month(date) %in% c(12, 1, 2) ~ "Winter",
      TRUE ~ "Unknown"
    )
  )

#### Subway
ttc_subway_delay <- ttc_subway_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),
    season = case_when(
      month(date) %in% c(3, 4, 5) ~ "Spring",
      month(date) %in% c(6, 7, 8) ~ "Summer",
      month(date) %in% c(9, 10, 11) ~ "Fall",
      month(date) %in% c(12, 1, 2) ~ "Winter",
      TRUE ~ "Unknown"
    )
  )

#### Filter Dataset for Holidays
#https://www.toronto.ca/home/contact-us/statutory-holidays/

# Holidays for 2024
holidays_2024 <- c(
  "2024-01-01",  # New Year’s Day
  "2024-02-19",  # Family Day
  "2024-03-29",  # Good Friday
  "2024-04-01",  # Easter Monday
  "2024-05-20",  # Victoria Day
  "2024-07-01",  # Canada Day
  "2024-08-05",  # Simcoe (Civic) Day
  "2024-09-02",  # Labour Day
  "2024-10-14",  # Thanksgiving Day
  "2024-11-11",  # Remembrance Day
  "2024-12-25",  # Christmas Day
  "2024-12-26"   # Boxing Day
)

# Convert holiday dates to Date class
holidays_2024 <- as.Date(holidays_2024)

# Add 'is_holiday' column to each dataset
ttc_bus_delay <- ttc_bus_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),  # Ensure date is in Date format
    is_holiday = ifelse(date %in% holidays_2024, 1, 0)  # 1 for holiday, 0 for non-holiday
  )

ttc_streetcar_delay <- ttc_streetcar_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),
    is_holiday = ifelse(date %in% holidays_2024, 1, 0)
  )

ttc_subway_delay <- ttc_subway_delay |>
  janitor::clean_names() |>
  mutate(
    date = as.Date(date),
    is_holiday = ifelse(date %in% holidays_2024, 1, 0)
  )

#### Data Cleaning
##Missing Values
ttc_bus_delay <- ttc_bus_delay %>%
  filter(!is.na(date) & !is.na(time) & !is.na(location))

ttc_streetcar_delay <- ttc_streetcar_delay %>%
  filter(!is.na(date) & !is.na(time) & !is.na(location))

ttc_subway_delay <- ttc_subway_delay %>%
  filter(!is.na(date) & !is.na(time) & !is.na(station))

#### Save data ####
write_csv(ttc_bus_delay, "cleaned_data/ttc_bus_delay.csv")
write_csv(ttc_streetcar_delay, "cleaned_data/ttc_streetcar_delay.csv")
write_csv(ttc_subway_delay, "cleaned_data/ttc_subway_delay.csv")
write_csv(ttc_subway_delay_code, "cleaned_data/ttc_subway_delay_code.csv")
