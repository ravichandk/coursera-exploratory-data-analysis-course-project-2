##Reading dataset from the file. This may take a while.
if(!exists("summarySCCPM25")) {
	summarySCCPM25 <- readRDS("summarySCC_PM25.RDS")
}

if(!exists("Source_Classification_Code")) {
	Source_Classification_Code <- readRDS("Source_Classification_Code.RDS")
}

## Filter the PM2.5 in Baltimore City, Maryland (fips == "24510")
baltimoreSummarySCCPM25 <- subset(summarySCCPM25, fips == "24510")

## Getting the total PM2.5 Emissions by type in Baltimore City, Maryland (fips == "24510") from  from 1999–2008.
baltimoreAggregateByYear <- aggregate(Emissions~year+type, baltimoreSummarySCCPM25, sum)

library(ggplot2)

png("plot3.png", width=640, height=480)

## Using ggplot2 to plot the above data.
ggplot(baltimoreAggregateByYear, aes(x=year, y=Emissions, color=type)) + 
	geom_line() + 
	xlab("year") + 
	ylab("Total PM2.5 Emissions") + 
	ggtitle("Total Emissions in Baltimore City from 1999 to 2008 by Type")
	
dev.off()