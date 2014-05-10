# readData.R

# installDeps()
# Install dependencies required by this script.
installAndLoadDeps <- function() {
  # Get the list of installed packages
  packageNames <- installed.packages()[,1]

  # Check if 'sqldf' is present
  if (!is.element("sqldf", packageNames)) {
    # If not, install it
    install.packages("sqldf")
  }

  # Return if package was successfully installed and loaded
  require("sqldf")
}


# downloadData()
# Download the data set archive, store it in a separate
# folder and unzip it for use.
downloadData <- function() {
  # URL for downloading data archive
  dataSetUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

  # Download data archive into a separate folder
  if (!file.exists("./data")) {
    dir.create("./data")
  }
  dataArchive <- "./data/power.zip"
  download.file(dataSetUrl, destfile=dataArchive, method="auto", mode="wb")

  # Unzip the archive to get raw data file
  unzip(dataArchive, exdir="./data")

  # Return if data was successfully extract
  file.exists("./data/household_power_consumption.txt")
}


# readData()
# Read data from the data file, suppressing unrequired rows,
# process date/time columns and return tidy data. 
readData <- function() {
  # Exit if dependencies could not be installed
  if (!installAndLoadDeps()) {
    message("unable to install dependencies")
    quit()
  }

  # Exit if data couldn't be downloaded or extracted from archive
  if (!downloadData()) {
    message("unable to obtain dataset")
    quit()
  }

  # Read the 'Date' and 'Time' columns as character initially and
  # read the other fields as numeric
  columnClasses <- c(rep("character", 2), rep("numeric", 7))

  # Read the data, scanning it and choosing only the required portion
  # [Note: 'hpc' stands for household power consumption.]
  hpcRaw <- read.csv.sql("data/household_power_consumption.txt",
                         sql="SELECT * FROM file WHERE Date == '1/2/2007' OR Date == '2/2/2007'",
                         sep=";", header=TRUE, colClasses=columnClasses)

  # Fuse the 'Date' and 'Time' columns and convert into date objects
  hpcRaw$Time <- strptime(paste(hpcRaw$Date, hpcRaw$Time), format="%d/%m/%Y %H:%M:%S")
  
  # Drop the 'Date' column as we no longer need it
  hpc <- hpcRaw[, 2:9]
  
  # Rename the date-time fused column
  colnames(hpc)[1] <- "datetime"

  # Return the tidied data
  hpc
}
