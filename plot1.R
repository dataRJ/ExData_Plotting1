plot1 <- function() {
        
        library(dplyr)
        
        ## download the zip file
        if(!file.exists("./data.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data.zip",method="curl")
        }
        
        ## Read file and subset to get only th required rows
        dataFile <- tbl_df(read.table(unz("data.zip","household_power_consumption.txt"),sep=";", header=TRUE,na.strings=c('?')))
        
        data <- subset(dataFile, Date %in% c('1/2/2007','2/2/2007'))
        
        ## Generate plot
        hist(data$Global_active_power,col='red',xlab="Global Active Power (kilowatts)",main="Global Active Power")
        
        ## Save to PNG 
        dev.copy(png,file="plot1.png")
        dev.off()
                
}