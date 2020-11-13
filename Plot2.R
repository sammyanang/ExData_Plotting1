# Install the package
install.packages("lubridate")
# Load the package
library(lubridate)
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)
filename <- "household_power_consumption.zip"

# Download data zip if not already done.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Unzip downloaded data zip
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}

#Read the file into R
fileUrl <- './household_power_consumption.txt'
household_energy_usage <- read.csv(fileUrl,sep = ";") 
#create a new column that has date and time
household_energy_usage <- mutate(household_energy_usage, new_dates = paste(household_energy_usage$Date,household_energy_usage$Time,sep = " "))
household_energy_usage$new_dates <- as.POSIXct(household_energy_usage$new_dates, format="%d/%m/%Y %H:%M:%S" )
#Convert to Date Date column
household_energy_usage$Date <- as.Date(parse_date_time(household_energy_usage$Date, orders = c("ymd", "dmy", "mdy")) )
#Convert to time Time column
household_energy_usage$Time <- strptime(household_energy_usage$Time,"%H:%M:%S" )
household_energy_usage$Global_active_power <- as.numeric(household_energy_usage$Global_active_power)
filtered_household_energy_usage <- household_energy_usage %>%  filter(between(Date, as.Date("2007-02-01"),as.Date("2007-02-02")))

#Create file device
png(file = "plot2.png", width = 480, height = 480, units = "px")
#Plot graph
with(filtered_household_energy_usage,
     plot(new_dates,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)")
     )
#Close the graphics device
dev.off()