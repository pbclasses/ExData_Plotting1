# read in data, adding in date and time fields in proper format
full = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
full$NewDate <- as.Date(full$Date, "%d/%m/%Y")
full$NewDateTime <- strptime(paste(full$Date, full$Time), "%d/%m/%Y %H:%M:%S")

# take only Feb 1, 2007 and Feb 2, 2007
twodays <- subset(full, NewDate == "2007-02-01" | NewDate == "2007-02-02")
rm(full)

# create histogram and save
hist(twodays$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()