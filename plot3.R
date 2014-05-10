# plot3.R
# Generates plot3 as per the requirements.

# Load the module that reads the data.
# Please see source file 'readData.R' for details on
# downloading, extracting, reading, processing and tidying up data.
source("readData.R")

# 'hpc' stands for household power consumption
hpc <- readData()

# Open a 'png' graphics device for saving the plot
png("plot3.png", width=480, height=480)

# Draw the base plot for sub-metering 1
plot(hpc$datetime, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

# Add the sub-metering 2 graph to the base plot
points(hpc$datetime, hpc$Sub_metering_2, type="l", col="red")

# Add the sub-metering 3 graph to the above plot
points(hpc$datetime, hpc$Sub_metering_3, type="l", col="blue")

# Add a legend box
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
       lty="solid")

# Save plot and close the graphics device
dev.off()
