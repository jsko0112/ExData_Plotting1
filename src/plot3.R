# 1. Get the data from URL
# 2. Make tidy data with subset
# 3. Cache the tidy data
source("./getting and cleaning.R")

#Plot Name : make the full plot name by common function(getPlotName())
plot.name <- "plot3"


#readData
data <- readData()

#save the plot as PNG
png(getPlotName(), width=480, height=480)

#make base plot
message("Making plot3!")
plot(x=data$Time, 
     y=data$Sub_metering_1, 
     ylab="Energy sub metering", 
     xlab="", 
     type="n")

#make point with "Sub_metering_1 ~ 3
points(x=data$Time, y=data$Sub_metering_1, type="l", col="black")
points(x=data$Time, y=data$Sub_metering_2, type="l", col="red")
points(x=data$Time, y=data$Sub_metering_3, type="l", col="blue")

legend(x="topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       text.col="black", 
       lty=c(1, 1, 1))

dev.off()