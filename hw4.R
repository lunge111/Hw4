data=read.csv("D:/1990.csv",colClasses=c("NULL",rep("integer",3),rep("NULL",4),"character",rep("NULL",5),"integer","NULL","character","character",rep("NULL",11)))
airport=names(sort(table(airportdat$airport),decreasing=T))[1:10]
carrier=unique(data$UniqueCarrier)
airp=read.csv("D:/airports.csv")
airp=airp[airp$iata%in%airport,]
airp
head(airportdat)
airpdat=data[data$Origin%in%airport,]
airportdat=merge(airpdat,airp,by.x="Origin",by.y="iata",all=T)


sub<-function(data,airport,carr,month=c(1,12),day1=c(1,31),day2=c(1,7))
  {data=data[data$UniqueCarrier==carr&data$airport==airport&
      data$Month>=month[1]&data$Month<=month[2]&data$DayofMonth>=day1[1]&
       data$DayofMonth<=day1[2]&data[,4]>=day2[1]&data[,4]<=day2[2],"ArrDelay"]
data}


library(shiny)
##set directory to shinyapp     
setwd("D:/shinyapp/shinyapp")
runApp()


slibrary(rCharts)
library(leaflet)
map3 <- Leaflet$new()
map3$setView(c(37.45, -93.85), zoom = 4)
for(i in 1:10) map3$marker(c(airp[i,6],airp[i,7]),
                           bindPopup=paste("<p>",airp[i,2],"in",airp[i,3],",",airp[i,4],"</P>",collapse=" " ))

map3$print("chart7")
map3
