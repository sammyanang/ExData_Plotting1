# Install the package
install.packages("lubridate")
# Load the package
library(lubridate)
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)
fileUrl <- 'c:/personalem/R/ExData_Plotting1/exdata_data_household_power_consumption/household_power_consumption.txt'
household_energy_usage <- read.csv(fileUrl,sep = ";") 
household_energy_usage$Date <- as.Date(parse_date_time(household_energy_usage$Date, orders = c("ymd", "dmy", "mdy")) )
household_energy_usage$Time <- strptime(household_energy_usage$Time,"%H:%M:%S" )
filtered_household_energy_usage <- household_energy_usage %>%  filter(between(Date, as.Date("2007-02-01"),as.Date("2007-02-02")))
