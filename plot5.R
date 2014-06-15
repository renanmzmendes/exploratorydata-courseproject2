# Reading data
message("Reading data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

message("Starting plot")
png("plot5.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)

# We are considering here "motor vehicle sources" as the sources with the following values
# for the attribute EI.Sector:
# = Mobile - On-Road Diesel Heavy Duty Vehicles
# = Mobile - On-Road Gasoline Heavy Duty Vehicles
# = Mobile - On-Road Diesel Light Duty Vehicles
# = Mobile - On-Road Gasoline Light Duty Vehicles

motor.sources <- SCC[which(SCC$EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Gasoline Light Duty Vehicles")),]
baltimore <- NEI[NEI$fips == "24510",]
baltimore.motor <- merge(baltimore, motor.sources, by.x="SCC", by.y="SCC")

emissions <- tapply(baltimore.motor$Emissions, as.factor(baltimore.motor$year), sum)
plot(levels(as.factor(baltimore.motor$year)), emissions, type="l", 
     xlab = "Year", ylab = "Emissions (tons)", 
     main = "Motor vehicle emissions per year in Baltimore City")
dev.off()
message("Plot finished")