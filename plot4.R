## Program: plot4.R
##
## Coursera exdata-032: Exploratory Data Analysis
## Author: Ryan Maley
##
##
plot4 <- function (){
        ##
        ## Produces multiple plots 
        ##        
        ZipArchive <- tempfile()
        ZipArchive <- "exdata_data_household_power_consumption.zip"
        
        ## Download the files - Uncomment when live
        ## download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",ZipArchive)

        ## Read the data and cut it based on the date
        TheData <- read.csv(unz(ZipArchive,"household_power_consumption.txt"),
                sep=";",stringsAsFactors = FALSE)
        TheData <- TheData[(TheData$Date=="1/2/2007" | TheData$Date=="2/2/2007"),]
        
        ## Convert the date from chr to date class, the time to POSIXlt
        TheData$Date <- as.Date(TheData$Date,"%d/%m/%Y")
        TheData$Time <- strptime(paste(TheData$Date, TheData$Time), format = "%Y-%m-%d %H:%M:%S")
        
        ## Create the PNG based file
        png(filename="plot4.png")
        
        ## Enable multiple plots on single page
        par(mfrow=c(2,2))
        
        ## Generate the line plot for global active power
        plot(TheData$Time,as.numeric(TheData$Global_active_power),type="l",
             ylab="Global Active Power")

        ## Generate a line plot for voltage
        plot(TheData$Time,as.numeric(TheData$Voltage),type="l"
             ,xlab="datetime",ylab="Voltage")
        
        ## Generate the line chart
        xrange <- range(TheData$Time)
        yrange <- range(as.numeric(TheData$Sub_metering_1))
        
        PlotColors <- c("black","red","blue")

        plot(xrange,yrange,type="n",xlab="",ylab="Energy sub metering")
        
        lines(TheData$Time,as.numeric(TheData$Sub_metering_1,type="l"))
        lines(TheData$Time,as.numeric(TheData$Sub_metering_2,type="l"),col="red")
        lines(TheData$Time,as.numeric(TheData$Sub_metering_3,type="l"),col="blue")
                          
        PlotColors <- c("black","red","blue")
        legend('topright','groups',col=PlotColors,lty=1,
               c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

        ## Generate line plot for global reactive power
        plot(TheData$Time,as.numeric(TheData$Global_reactive_power),type="l",
             xlab="datetime", ylab="Global_reactive_power")
        
        ## Close the graphics device
        dev.off()
}        