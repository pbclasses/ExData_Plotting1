# read in data, adding in date and time fields in proper format
full = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
full$NewDate <- as.Date(full$Date, "%d/%m/%Y")
full$NewDateTime <- strptime(paste(full$Date, full$Time), "%d/%m/%Y %H:%M:%S")

# take only Feb 1, 2007 and Feb 2, 2007
twodays <- subset(full, NewDate == "2007-02-01" | NewDate == "2007-02-02")
rm(full)

# determine weekday for label purposes
twodays$Day <- weekdays(twodays$NewDate, abbreviate = TRUE)

# upper left plot
par(mfrow=c(2,2))
plot(twodays$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power")
axis(1, c(1, length(twodays$Day)/2, length(twodays$Day)), c("Thu", "Fri", "Sat"))

# upper right plot
plot(twodays$Voltage, type="l", xaxt="n", xlab="datetime", ylab="Voltage")
axis(1, c(1, length(twodays$Day)/2, length(twodays$Day)), c("Thu", "Fri", "Sat"))

# lower left plot
plot(twodays$Sub_metering_1, type="l", xaxt="n", xlab="", ylab="Energy sub metering")
lines(twodays$Sub_metering_2, col="red")
lines(twodays$Sub_metering_3, col="blue")
axis(1, c(1, length(twodays$Day)/2, length(twodays$Day)), c("Thu", "Fri", "Sat"))
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') , lty=1, col=c('black', 'red', 'blue'), border="none")

# lower right plot
plot(twodays$Global_reactive_power, type="l", xaxt="n", xlab="datetime", ylab="Global_reactive_power")

# save file
dev.copy(png, file="plot4.png")
dev.off()