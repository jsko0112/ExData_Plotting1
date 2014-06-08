# Getting and Cleaning Data

#data file url
datafile.name.url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#data file name
datafile.name <- "household_power_consumption.txt"

#directory of data which is downloaded 
data.dir <- paste(getwd(),"/data",sep="")

#local and tidy local file name
local.file.name <- paste(data.dir, "/", datafile.name, sep="")
cache.file.name <- paste(data.dir, "/", paste("cached", datafile.name, sep="_"), sep="")

#place to store 
generated.data.dir<-paste(getwd(),"/src/generated/resources/",sep="")

#read the data and make data set
readData <- function() {
  if(!file.exists(cache.file.name)){
    makeTidyData()
  } else {
    message("Reusing cached data")
    
    #dput() and dget() function write or read an ASCII text representation of an R object
    #to a file or connection, or uses one to recreate the object.
    dget(file=cache.file.name)
  }
}

#process the local set of raw data and prepare it for exploration, see message() calls for comments
makeTidyData <- function() {
  getCachedData()
  
  message("Loading data...")
  data <- read.csv(local.file.name, 
                   header=T, 
                   sep=";", 
                   colClasses=c("character", "character", "character", "character", "character", "character", "character", "character"))
  
  message("Make tidy data : subset")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  left.boundary <- data$Date >= as.Date("2007-02-01")
  right.boundary <- data$Date <= as.Date("2007-02-02")
  data <- data[left.boundary & right.boundary, ]
  
  message("Make tidy data : casting")
  data$Time <- strptime(paste(data$Date, data$Time),format="%Y-%m-%d %H:%M:%S")
  data$Global_active_power <- as.numeric(data$Global_active_power)
  data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
  data$Voltage <- as.numeric(data$Voltage)
  data$Global_intensity <- as.numeric(data$Global_intensity)
  data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
  data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
  data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
  
  message("Caching tidy data")
  dput(data, file=cache.file.name)
  
  message("Finished making tidy data!")
  data
}

#verify the existence of a local set of raw data, 
#otherwise try to gather from internet (from Coursera)
getCachedData <- function(...) {
  # find local.file.name(./data/household_power_consumption.txt)
  if(!file.exists(local.file.name)){
    
    #create the directory of data file
    dir.create(data.dir, recursive=T, showWarnings=F)
    
    #download the data file(zip file) and unzip it
    getData(local.file.name)
  } else {
    #Using cached data
    message("Using cached data")
  }
}

#download the data file(zip file) and unzip it
getData <- function(local.file.name) {
  message("start getting data")
  tmp.file.name <- paste(local.file.name, ".zip", sep="")
  message("download data file")
  download.file(datafile.name.url, tmp.file.name, method="auto", quiet=F)
  message("start unzip!!")
  unzip(zipfile=tmp.file.name, overwrite=T, exdir=data.dir)
  file.remove(tmp.file.name)
  message("complete unzip!")
}

#clear the local cache
clearCachedData <- function(raw=T, tidy=T) {
  if(raw & file.exists(local.file.name))
    file.remove(local.file.name)
  if(tidy & file.exists(cache.file.name))
    file.remove(cache.file.name)
  
  message("Local cache cleared")
}

# Common : make the plot name
getPlotName <- function() {
  dir.name <- paste(getwd(), "/output/", sep="")
  dir.create(dir.name, showWarnings=F, recursive=T)
  paste(dir.name, plot.name, ".png", sep="")
}
