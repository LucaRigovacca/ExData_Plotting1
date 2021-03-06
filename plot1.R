# Load the data, first we check the class in order to speed up the acquisition
upperData <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", nrows = 5, sep = ";")
classList <- sapply(upperData, class)
totalData <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", nrows = 2075259, sep = ";", colClasses = classList)

# Convert the Time and Date to a more friendly format
library(lubridate)
totalData$Date <- dmy(totalData$Date)


# Retain only the observations for the desired dates
library(dplyr)

DateRange <- dmy(c("01-02-2007","02-02-2007"))
Data <- totalData %>% filter(Date %in% DateRange)

# Create datetime variable 
Data$datetime <- Data$Date + hms(Data$Time) 


# First Plot
png("plot1.png", width = 480, height = 480)
hist(Data$Global_active_power, nclass = 12, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
