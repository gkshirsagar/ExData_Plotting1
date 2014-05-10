# plot2.R
# Generates plot2 as per the requirements.

# Load the module that reads the data.
# Please see source file 'readData.R' for details on
# downloading, extracting, reading, processing and tidying up data.
source("readData.R")

# 'hpc' stands for household power consumption
hpc <- readData()

# Open a 'png' graphics device for saving the plot
png("plot2.png", width=480, height=480)

# Draw the plot
plot(hpc$datetime, hpc$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

# Save plot and close the graphics device
dev.off()
