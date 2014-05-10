# plot4.R
# Generates plot4 as per the requirements.

# Load the module that reads the data.
# Please see source file 'readData.R' for details on
# downloading, extracting, reading, processing and tidying up data.
source("readData.R")

# 'hpc' stands for household power consumption
hpc <- readData()

# Open a 'png' graphics device for saving the plot
png("plot4.png", width=480, height=480)

# Setup a grid of 2x2 for drawing the plot
par(mfcol=c(2,2))

# Draw plot2 (with slightly different label) at top-left
plot(hpc$datetime, hpc$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# Draw plot3 (with slight changes: no box for legend) at bottom-left
plot(hpc$datetime, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(hpc$datetime, hpc$Sub_metering_2, type="l", col="red")
points(hpc$datetime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty="solid", bty="n")

# Draw voltage plot at top-right
with(hpc, plot(datetime, Voltage, type="l"))

# Draw global reactive power plot at bottom-rigth
with(hpc, plot(datetime, Global_reactive_power, type="l"))

# Save plot and close the graphics device
dev.off()
