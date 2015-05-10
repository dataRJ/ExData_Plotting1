plot2 <- function() {
        
        library(dplyr)

        ## download the zip file
        if(!file.exists("./data.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data.zip",method="curl")
        }
        
        ## Read file and subset to get only th required rows
        dataFile <- tbl_df(read.table(unz("data.zip","household_power_consumption.txt"),sep=";", header=TRUE,na.strings=c('?')))
        
        data <- subset(dataFile, Date %in% c('1/2/2007','2/2/2007'))
        
        ## Modify data frame to have date and time present as a proper POSIXct
        data2 <- mutate(data,dTime = as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S"))
        
        ## Generate the line plot
        png(file = "plot2.png", bg="white", height=480, width=480)
        plot(data2$dTime, data2$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        dev.off()
        
}