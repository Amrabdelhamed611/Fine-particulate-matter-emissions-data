##PM2.5(dust) emission from all sources for each of the years 1999, 2002, 2005, and 2008 in USA
#download the data from the link
if(!file.exists("Dataset.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile= "Dataset.zip") 
}
##unzip the data
if(!file.exists('household_power_consumption.txt')  ){
    unzip("Dataset.zip" ) 
}
## read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
sclist<-grep("vehicle",unique(SCC$EI.Sector),value = TRUE,ignore.case = TRUE)
vehiclescc<-SCC[SCC$EI.Sector %in% sclist,1]
vehicledata<-subset(NEI,SCC %in% vehiclescc)
vehicleyearTotalEmissions <-with(vehicledata,tapply(Emissions, year, FUN = sum,na.rm = "True"))
png(filename = "plot5.png",width = 480, height = 480) 
plot(names(vehicleyearTotalEmissions) ,
     vehicleyearTotalEmissions/10**3 ,
     xlab ="year",
     ylab="PM2.5 Emissions (K tons)" ,
     pch = 19,
     col = "red",
     xaxt="none",
     main = "PM2.5 Total Emissions for motor vehicle sources")
lines(x=names(vehicleyearTotalEmissions),y= vehicleyearTotalEmissions/10**3,lwd = 2,type = "c")
axis(1, names(vehicleyearTotalEmissions))
dev.off()
