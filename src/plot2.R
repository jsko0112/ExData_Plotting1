# 1. Get the data from URL
# 2. Make tidy data with subset
# 3. Cache the tidy data
source("./getting and cleaning.R")

#Plot Name : make the full plot name by common function(getPlotName())
plot.name <- "plot2"

#readData
data <- readData()

#save the plot as PNG
png(getPlotName(), width=480, height=480)
message("Making plot2!")
plot(x=ds$Time, 
     y=ds$Global_active_power, 
     ylab="Global Active Power (kilowatts)", 
     xlab="", 
     type="l")
dev.off()