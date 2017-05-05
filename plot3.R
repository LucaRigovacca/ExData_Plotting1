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



# Third Plot 
png("plot3.png", width = 480, height = 480)
with(Data, plot(datetime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(Data, lines(datetime, Sub_metering_1, col = "black"))
with(Data, lines(datetime, Sub_metering_2, col = "red"))
with(Data, lines(datetime, Sub_metering_3, col = "blue"))
legendNames <- c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
legendCols <- c("black","red", "blue")
legend("topright", lty=c(1,1), col = legendCols, legend = legendNames)
dev.off()
