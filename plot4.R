plot4 <- function() {
        
        library(dplyr)
        
        ## download the zip file
        if(!file.exists("./data.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data.zip",method="curl")
        }
        
        ## Read file and subset to get only th required rows
        dataFile <- tbl_df(read.table(unz("data.zip","household_power_consumption.txt"),sep=";", header=TRUE,na.strings=c('?')))
        
        data <- subset(dataFile, Date %in% c('1/2/2007','2/2/2007'))
        
        ## Modify data frame to have date and time present as a proper POSIXct
        data4 <- mutate(data,dTime = as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S"))

        ##Prepare the plot
        png(file = "plot4.png", bg="white", height=480, width=480)
        par(mfrow = c(2,2))
        
        ## 1st plot top left
        plot(data4$dTime, data2$Global_active_power,type="l",ylab="Global Active Power",xlab="")
        
        ## 2nd plot top right
        plot(data2$dTime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
        
        ## 3rd plot bottom left
        plot(data4$dTime,data4$Sub_metering_1,type="n", ylab="Energy sub metering", xlab="")
        lines(data4$dTime,data4$Sub_metering_1)
        lines(data4$dTime,data4$Sub_metering_2, col="red")
        lines(data4$dTime,data4$Sub_metering_3, col="blue")
        legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c("black","red","blue"),bty="n")
        
        ## 4th plot bottom right
        plot(data4$dTime, data4$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        
        dev.off()
        
}