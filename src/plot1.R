# 1. Get the data from URL
# 2. Make tidy data with subset
# 3. Cache the tidy data
source("./getting and cleaning.R")

#Plot Name : make the full plot name by common function(getPlotName())
plot.name <- "plot1"

#readData
data <- readData()

#save the plot as PNG
png(getPlotName(), width=480, height=480)

#create plot
message("Making plot1!")
hist(data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="red")

dev.off()

