## Program: plot1.R
##
## Coursera exdata-032: Exploratory Data Analysis
## Author: Ryan Maley
##
##
plot1 <- function (){
        ##
        ## Produces a Global Active Power Plot
        ##        
        ZipArchive <- tempfile()
        ZipArchive <- "exdata_data_household_power_consumption.zip"
        
        ## Download the files - Can be commented out once downloaded, I suppose
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",ZipArchive)

        ## Read the data and cut it based on the date
        TheData <- read.csv(unz(ZipArchive,"household_power_consumption.txt"),
                sep=";",stringsAsFactors = FALSE)
        TheData <- TheData[(TheData$Date=="1/2/2007" | TheData$Date=="2/2/2007"),]
        
        ## Convert the date from chr to date class, the time to POSIXlt
        TheData$Date <- as.Date(TheData$Date,"%m/%d/%Y")
        TheData$Time <- strptime(paste(TheData$Date, TheData$Time), format = "%Y-%m-%d %H:%M:%S")
        
        ## Create the PNG based file
        png(filename="plot1.png")
        
        ## Generate the histogram for Plot 1
        hist(as.numeric(TheData$Global_active_power),col="red",
             main="Global Active Power",
             xlab="Global Active Power (kilowatts)"
             )
        ## Close the graphics device
        dev.off()
}        