# Reading data
message("Reading data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(plyr)

message("Starting plot")
png("plot6.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)

# We are considering here "motor vehicle sources" as the sources with the following values
# for the attribute EI.Sector:
# = Mobile - On-Road Diesel Heavy Duty Vehicles
# = Mobile - On-Road Gasoline Heavy Duty Vehicles
# = Mobile - On-Road Diesel Light Duty Vehicles
# = Mobile - On-Road Gasoline Light Duty Vehicles

motor.sources <- SCC[which(SCC$EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Gasoline Light Duty Vehicles")),]
balt.la <- NEI[NEI$fips %in% c("24510", "06037"),]
balt.la.motor <- merge(balt.la, motor.sources, by.x="SCC", by.y="SCC")
emissions <- ldply(by(balt.la.motor, list(as.factor(balt.la.motor$year), as.factor(balt.la.motor$fips)), 
   function(df) { data.frame(Emissions = sum(df$Emissions), year = df$year[1], fips = ifelse(df$fips[1] == "24510", "Baltimore City", "Los Angeles")) }))

qplot(year, Emissions, data = emissions, facets = .~fips, geom = "line")
dev.off()
message("Plot finished")