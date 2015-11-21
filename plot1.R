##Reading dataset from the file. This may take a while.
if(!exists("summarySCCPM25")) {
	summarySCCPM25 <- readRDS("summarySCC_PM25.RDS")
}

if(!exists("Source_Classification_Code")) {
	Source_Classification_Code <- readRDS("Source_Classification_Code.RDS")
}

##Get total emissions from PM2.5 decreased in the United States from 1999 to 2008
aggregateByYear <- aggregate(Emissions~year, summarySCCPM25, sum)

png("plot1.png")

## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008 using BASE plot system
barplot(height = aggregateByYear$Emissions, names.arg = aggregateByYear$year, xlab = "years", ylab = "Total PM 2.5 Emission", main="Year wise total PM 2.5 Emissions")

dev.off()
