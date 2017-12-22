# read in data, adding in date and time fields in proper format
full = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
full$NewDate <- as.Date(full$Date, "%d/%m/%Y")
full$NewDateTime <- strptime(paste(full$Date, full$Time), "%d/%m/%Y %H:%M:%S")

# take only Feb 1, 2007 and Feb 2, 2007
twodays <- subset(full, NewDate == "2007-02-01" | NewDate == "2007-02-02")
rm(full)

# determine weekday for label purposes
twodays$Day <- weekdays(twodays$NewDate, abbreviate = TRUE)

# create graph and save
plot(twodays$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
axis(1, c(1, length(twodays$Day)/2, length(twodays$Day)), 
     c(twodays$Day[1], twodays$Day[length(twodays$Day)/2], twodays$Day[length(twodays$Day)]))
dev.copy(png, file="plot2.png")
dev.off()