# Project 1 Plot 2
# Author: jdhuffaker
# Date: 04/11/15

# File Directory
filepath <- "C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/04 Exploratory Data Analysis/"

# Read in full table and set "?" to NA
#hpc <- read.table(paste(filepath,"household_power_consumption.txt", sep=""), sep=";", 
#                  header=TRUE, na.strings=c("?"))

# Read in subset table (2/1/2007 to 2/2/2007); read in 1st line and unlist as column names
header <- read.table(paste(filepath,"household_power_consumption.txt", sep=""), 
                     nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
hpc <-read.table(paste(filepath,"household_power_consumption.txt", sep=""),
                 header=FALSE, skip=66637,nrows=2880, sep=";", na.strings=c("?"))
colnames( hpc ) <- unlist(header)

#head(hpc)
#tail(hpc)
#str(hpc)

# Create a Date_Time Column and move it next to Time
hpc$Date_Time <- paste(hpc$Date, hpc$Time)
hpc$Date_Time <- strptime(hpc$Date_Time, "%d/%m/%Y %H:%M:%S")
hpc <- hpc[,c(1,2,10,3,4,5,6,7,8,9)]


# Change date and time from Factor to Date and Time formats
hpc$Date <- as.Date(as.character(hpc$Date),"%d/%m/%Y")
#hpc$Time2 <- as.POSIXlt(as.character(hpc$Time),format="%H:%M:%S")
#hpc$Time2 <- NULL

# Create subset of 2/1/2007 to 2/2/2007 dates if full table is read in
#hpc2 <- subset(hpc, as.Date(hpc$Date) >= "2007-02-01" & as.Date(hpc$Date) <= "2007-02-02")

# Create a Week Data variable (not used)
hpc$Day <- weekdays(as.Date(hpc$Date))

# Write to a PNG file
png(filename = "plot2.png", width=480, height=480, units="px")
# Plot Global Active Power over time; Weekday is automatically set on the X axis
plot(hpc$Date_Time, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
#dev.copy(png, file = "plot2.png", width=480, height=480, units="px") ## Copy plot to a PNG file
dev.off() ## Close the PNG device