library(plyr)
library(ggplot2)
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
#for the four types of sources which of these four sources have seen decreases in emissions 
#from 1999–2008 in Baltimore City?
png(filename = "plot3.png",width = 480, height = 480) 
BaltimoreCity <- subset(NEI,fips == "24510")
BaltimoreCity <-BaltimoreCity[,c(4,5,6)]
TotalEmissions <- ddply(BaltimoreCity,.(type,year),summarize,sum= sum(Emissions,na.rm = TRUE))

g <- ggplot(data =TotalEmissions, aes(x= as.factor(year),y = sum, group=type,color = type))
(g+geom_line(linetype = "dashed")
  + geom_point(size=2) 
  + labs(x= "year" ,y="PM2.5 Emissions (tons)")
  + labs(title="PM2.5 Emissions in Baltimore City for each type of sources",lwd=3) 
)
dev.off()
