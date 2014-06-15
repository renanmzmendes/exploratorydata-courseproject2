# Reading data
message("Reading data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(plyr)

message("Starting plot")
png("plot3.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)
baltimore <- NEI[NEI$fips == "24510",]
emissions <- ldply(by(baltimore, list(as.factor(baltimore$year), as.factor(baltimore$type)), 
                      function(df) { data.frame(Emissions = sum(df$Emissions), type = df$type, year = df$year) }))
qplot(year, Emissions, data = emissions, facets = .~type, geom = "line")
dev.off()
message("Plot finished")