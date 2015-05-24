library(dplyr)
library(ggplot2)
library(scales)

#Read file MonthlyPassengerData_200507_to_201503.csv
file <- "Passenger/SFO_Passenger_Data/MonthlyPassengerData_200507_to_201503.csv"
SFO_data <- read.csv(unz("data/Passenger.zip", file), 
                     nrows = 13533)[, c(1:2, 6:8, 10:12)]

#convert to date format the column Activity.Period
SFO_data$Activity.Period <- as.Date(paste(
                                    as.character(SFO_data$Activity.Period), 
                                    "01", sep = ""), "%Y%m%d")

filterByPeriod <- function (data, minDate, maxDate, region, action_type, terminal){
    minDate <- as.Date(paste(format(minDate, "%Y-%m"), "01", sep = "-"))
    maxDate <- as.Date(paste(format(maxDate, "%Y-%m"), "01", sep = "-"))
    data <- data %>% 
        filter(Activity.Period >= minDate, Activity.Period <= maxDate, 
               GEO.Region %in% region, Activity.Type.Code %in% action_type,
               Terminal %in% terminal) %>% 
        group_by(Activity.Period, GEO.Region, Activity.Type.Code, Terminal) %>% 
        summarise(Passenger.Count = sum(Passenger.Count))
}

group_by_fields <- function (data, fields){
    data <- data %>% 
        group_by_(.dots=fields) %>% 
        summarise(Passenger.Count = sum(Passenger.Count))
}