library(lubridate)

# Read Data Set without Headers
rawDataset <- read.table("exdata-data-household_power_consumption/household_power_consumption.txt", skip = 1, sep = ";", colClasses = "character")

# Assign Headers
headerNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
names(rawDataset) <- headerNames

#Create new combined date time variable
rawDataset$newDate <- with(rawDataset, paste(rawDataset$Date, rawDataset$Time))

# Convert newDate from Char to Posix
rawDataset$newDate <- lubridate::dmy_hms(rawDataset$newDate)

#rawDataset$Date <- as.Date(rawDataset$Date)
#rawDataset$Time <- strptime(rawDataset$Time, format = "%H:%M:%S")

#convert measurement variables from char to numeric
rawDataset$Global_active_power <- as.numeric(rawDataset$Global_active_power)
rawDataset$Global_reactive_power <- as.numeric(rawDataset$Global_reactive_power)
rawDataset$Voltage <- as.numeric(rawDataset$Voltage)
rawDataset$Sub_metering_1 <- as.numeric(rawDataset$Sub_metering_1)
rawDataset$Sub_metering_2 <- as.numeric(rawDataset$Sub_metering_2)
rawDataset$Sub_metering_3 <- as.numeric(rawDataset$Sub_metering_3)

# Subset Data Set
testInterval <- new_interval(ymd("2007-02-01"), ymd("2007-02-03"))
subDataset <- rawDataset[rawDataset$newDate %within% testInterval,]

## Construct Plot2 
plot(subDataset$newDate, subDataset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "" )

# Save plot to a PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

#remove datasets
rm(rawDataset, subDataset, headerNames, testInterval)
graphics.off()
