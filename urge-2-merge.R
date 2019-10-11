library(tidyverse)
NOAA <- read.csv("https://www.aavso.org/sites/default/files/solar/NOAAfiles/daily%20%281%29.csv")
NOAA$Ymd <- as.Date(paste(NOAA$Year, NOAA$Month, NOAA$Day, sep = "-"))
NOAA <- NOAA %>% filter(Year >=1945) %>% select(Ymd,Ra)
summary(NOAA)

SIDC<-read.csv("http://sidc.be/silso/DATA/SN_d_tot_V2.0.csv",sep = ';')
# ADD column names
colnames(SIDC) <- c("Year","Month","Day", "Fdate","SIDC", "Sd","Obs" ,"Defin"  )
SIDC$Ymd <- as.Date(paste(SIDC$Year, SIDC$Month, SIDC$Day, sep = "-"))
SIDC <- SIDC %>% filter(Year >=1945) %>% select(Ymd,SIDC)
summary(SIDC)

merged <- inner_join(SIDC,NOAA, by="Ymd")
summary(merged)
merged$Dif <- merged$SIDC - merged$Ra


options(repr.plot.width = 12, repr.plot.height = 6)
ggplot(data=merged,aes(x=Ymd,y=SIDC,col="SIDC")) +geom_col() +
geom_col(data=merged,aes(x=Ymd,y=Ra,col="NOAA")) 
theme(text = element_text(size = 24), element_line(size = 0.4))mary(merged)

options(repr.plot.width = 12, repr.plot.height = 6)
ggplot(data=merged,aes(x=Ymd,y=SIDC,col="SIDC")) +geom_col() +
geom_col(data=merged,aes(x=Ymd,y=Ra,col="NOAA")) 
theme(text = element_text(size = 24), element_line(size = 0.4))

options(repr.plot.width = 12, repr.plot.height = 6)
ggplot(data=merged,aes(x=Ymd,y=SIDC,col="SIDC")) +geom_smooth(method="loess") +
geom_smooth(data=merged,aes(x=Ymd,y=Ra,col="NOAA"),method="loess")
theme(text = element_text(size = 24), element_line(size = 0.4))

ggplot(data=merged,aes(x=Ymd,y=Dif,col="Dif")) +geom_col()
