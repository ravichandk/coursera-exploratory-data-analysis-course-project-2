##Reading dataset from the file. This may take a while.
if(!exists("summarySCCPM25")) {
	summarySCCPM25 <- readRDS("summarySCC_PM25.RDS")
}

if(!exists("Source_Classification_Code")) {
	Source_Classification_Code <- readRDS("Source_Classification_Code.RDS")
}

## Merge the data sets get the classifications.
if(!exists("summarySCCPM25WithClassification")) {
	summarySCCPM25WithClassification <- merge(summarySCCPM25, Source_Classification_Code, by="SCC")
}

## Emissions from motor vehicle sources in Baltimore city
baltimoreMotorVehicleData <- subset(summarySCCPM25WithClassification, fips=="24510" & type=="ON-ROAD")

## Total PM2.5 Emissions from motor vehicle sources in Baltimore city
baltimoreAggregateByYear <- aggregate(Emissions~year+type, baltimoreMotorVehicleData, sum)

library(ggplot2)

png("plot5.png", width=640, height=480)

## Plot the above data using ggplot2 system.
g <- ggplot(baltimoreAggregateByYear, aes(x=factor(year), y=Emissions)) 
g <- g +geom_bar(stat = "identity")
g <- g + xlab("year") + ylab("Total PM 2.5 Emissions") + ggtitle("Total Emissions from coal sources from 1999 to 2008")

print(g)
 
dev.off()