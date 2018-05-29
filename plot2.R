pow <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
## Format date to Type Date
pow$Date <- as.Date(pow$Date,"%d/%m/%Y")
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
pow <- subset(pow,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
## Remove incomplete observation
pow <- pow[complete.cases(pow),]
## Combine Date and Time column
dateTime <- paste(pow$Date, pow$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
## Remove Date and Time column
pow <- pow[ ,!(names(pow) %in% c("Date","Time"))]
## Add DateTime column
pow <- cbind(dateTime, pow)
## Format dateTime Column
pow$dateTime <- as.POSIXct(dateTime)
## Create Plot 2
plot(pow$Global_active_power~pow$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()