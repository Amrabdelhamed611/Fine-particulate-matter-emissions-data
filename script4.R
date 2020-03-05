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
#Across the US,how have emissions from coal combustion-related sources changed from 1999–2008?
png(filename = "plot4.png",width = 480, height = 480) 
sclist<-grep("Coal",unique(SCC$EI.Sector),value = TRUE,ignore.case = TRUE)
coalscc<-SCC[SCC$EI.Sector %in% sclist,1]
coaldata<-subset(NEI,SCC %in% coalscc)
coalyearTotalEmissions <-with(coaldata,tapply(Emissions, year, FUN = sum,na.rm = "True"))
plot((names(coalyearTotalEmissions)) ,
     coalyearTotalEmissions/10**3 ,
     xlab ="year",
     ylab="PM2.5 Emissions (K tons)" ,
     pch = 19,
     col = "red",
     xaxt="none",
     main = "PM2.5 Emissions for coal combustion-related sources")
lines(x=names(coalyearTotalEmissions),y= coalyearTotalEmissions/10**3,lwd = 2,type = "c")
axis(1, names(coalyearTotalEmissions))
dev.off()
