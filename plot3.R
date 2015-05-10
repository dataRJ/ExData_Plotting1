plot3 <- function() {
        
        library(dplyr)
        
        ## download the zip file
        if(!file.exists("./data.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data.zip",method="curl")
        }
        
        ## Read file and subset to get only th required rows
        dataFile <- tbl_df(read.table(unz("data.zip","household_power_consumption.txt"),sep=";", header=TRUE,na.strings=c('?')))
        
        data <- subset(dataFile, Date %in% c('1/2/2007','2/2/2007'))
        
        ## Modify data frame to have date and time present as a proper POSIXct
        data3 <- mutate(data,dTime = as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S"))
        
        ## Generate the line plot
        png(file = "plot3.png", bg="white", height=480, width=480)
        plot(data3$dTime,data3$Sub_metering_1,type="n", ylab="Energy sub metering", xlab="")
        lines(data3$dTime,data3$Sub_metering_1)
        lines(data3$dTime,data3$Sub_metering_2, col="red")
        lines(data3$dTime,data3$Sub_metering_3, col="blue")
        legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c("black","red","blue"))
        dev.off()
        
}