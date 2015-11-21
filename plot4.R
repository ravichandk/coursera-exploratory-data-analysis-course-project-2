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

## Get the rows which may contain coal combustion-related sources data.
coalMatches <- grep("coal", summarySCCPM25WithClassification$Short.Name, ignore.case = TRUE)
coalSCCPM <- summarySCCPM25WithClassification[coalMatches,]

## Get the total PM2.5 Emissions from coal combustion-related sources.
coalDataAggregateByYear <- aggregate(Emissions~year+type, coalSCCPM, sum)

library(ggplot2)

png("plot4.png", width=640, height=480)

## Using ggplot2 system to plot the above data.
g <- ggplot(coalDataAggregateByYear, aes(x=factor(year), y=Emissions)) 
g <- g +geom_bar(stat = "identity")
g <- g + xlab("year") + ylab("Total PM 2.5 Emissions") + ggtitle("Total Emissions from coal sources from 1999 to 2008")

print(g)
 
dev.off()