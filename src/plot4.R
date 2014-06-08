# 1. Get the data from URL
# 2. Make tidy data with subset
# 3. Cache the tidy data
source("./getting and cleaning.R")

#Plot Name : make the full plot name by common function(getPlotName())
plot.name <- "plot4"

#readData
data <- readData()

#save the plot as PNG
png(getPlotName(), width=480, height=480)

#prepare the grid (2x2)
par(mfrow=c(2,2))

#top left diagram
message("Making plot4 - top left")
plot(x=ds$Time, 
     y=ds$Global_active_power, 
     ylab="Global Active Power", 
     xlab="", 
     type="l")

#top right diagram
message("Making plot4 - top right")
plot(x=ds$Time, 
     y=ds$Voltage, 
     ylab="Voltage", 
     xlab="datetime", 
     type="l")

#bottom left diagram
message("Making plot4 - bottom left")
plot(x=ds$Time, 
     y=ds$Sub_metering_1, 
     ylab="Energy sub metering", 
     xlab="", 
     type="n")
points(x=ds$Time, y=ds$Sub_metering_1, type="l", col="black")
points(x=ds$Time, y=ds$Sub_metering_2, type="l", col="red")
points(x=ds$Time, y=ds$Sub_metering_3, type="l", col="blue")
legend(x="topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       text.col="black", 
       lty=c(1, 1, 1), 
       bty="n", 
       cex=0.9)

#bottom right diagram
message("Making plot4 - bottom right")
plot(x=ds$Time, 
     y=ds$Global_reactive_power,
     ylab="Global_reactive_power", 
     xlab="datetime", 
     type="l")

dev.off()