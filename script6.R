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
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
sclist<-grep("vehicle",unique(SCC$EI.Sector),value = TRUE,ignore.case = TRUE)
vehiclescc<-SCC[SCC$EI.Sector %in% sclist,1]
vehicledata<-subset(NEI,SCC %in% vehiclescc)
vehicledata<-subset(vehicledata,fips %in% c("24510","06037"))
TotalEmissions <- ddply(vehicledata,.(fips,year),summarize,sum= sum(Emissions,na.rm = TRUE))
png(filename = "plot6.png",width = 480, height = 480) 

g <- ggplot(data =TotalEmissions, aes(x= as.factor(year),y = sum, group=fips,color = fips))
(g+geom_line(linetype = "dashed")
    + geom_point(size=2) 
    + labs(x= "year" ,y="PM2.5 Emissions (tons)")
    + guides(color=guide_legend("city")) 
    +scale_color_manual(labels = c("California","Baltimore"), values = c("blue", "red"))
    + labs(title="comparing PM2.5 Emissions in Baltimore and California",lwd= 3) 
)
dev.off()
