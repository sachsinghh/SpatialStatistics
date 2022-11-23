library(maptools) 

library(sp) 

library(foreign) 

library(lattice) 

library(rgdal) 

library(RColorBrewer) 

library(classInt) 

library(class) 

library(e1071) 

library(shapefiles) 

install.packages("geojsonio")
library(geojsonio) 

library(readxl) 



##################### PURELY SPASIAL MODEL POISSON ################################ 

x <- readShapeSpatial("C:/Users/Sachi/Downloads/SHP_Jabar/SHP_Jabar/kabkot_jawabarat.shp") 
x@data

plot(x) 

PurelyPoisson  <- X2018_hotspot
str(PurelyPoisson)
plot(x, border="blue", axes=TRUE, las=1) 

x@data$row <- as.numeric(row.names(x@data)) 

str(PurelyPoisson) 

head(PurelyPoisson) 

PurelyPoisson$nama_kabupaten_kota<-as.factor(PurelyPoisson$nama_kabupaten_kota) 

x@data$row <- as.numeric(row.names(x@data)) 

x@data$no <- as.numeric(row.names(x@data)) 

colnames(PurelyPoisson)[1]="no"
temp <- merge(x@data, PurelyPoisson, by="no", all.x=T, sort=F) 


x@data <- temp[order(temp$row),] 

plotvar <- x@data$c1 

str(x@data$jumlah_c1) 

nclr <- 4 

plotclr <- brewer.pal(nclr,"Greens") 

plotclr <- plotclr[1:nclr] 

class <- classIntervals(plotvar, nclr, style="equal") 

colcode <- findColours(class, plotclr, digits=4) 

plot(x, density=16, col="grey", axes=T, cex.axis=.75) 

plot(x, col=colcode, add=T) 

text(coordinates(x), labels=x$nama_kabupaten_kota, cex=.55) 

title(xlab="x",ylab='y',cex.lab=.75,line=2.25) 

title(main="Area Klaster Jumlah Balita Stunting di Jawa Barat 2018", sub="Mapped with R",font.sub=2) 



##################### SPACE TIME MODEL POISSON ################################ 

x<-readShapeSpatial("C:/Users/hafsa/Downloads/SHP_Jabar/kabkot_jawabarat.shp") 

plot(x) 

SpacePoisson <- read_excel("C:/Users/hafsa/Downloads/dinkes-jumlah_balita_stunting_berdasarkan_kabupatenkota_data.xlsx", 
                           
                           sheet = "Sheet1") 

plot(x, border="blue", axes=TRUE, las=1) 

x@data$row <- as.numeric(row.names(x@data)) 

str(SpacePoisson) 

head(SpacePoisson) 

SpacePoisson$nama_kabupaten_kota<-as.factor(SpacePoisson$nama_kabupaten_kota) 

x@data$row <- as.numeric(row.names(x@data)) 

x@data$no <- as.numeric(row.names(x@data)) 

temp <- merge(x@data, SpacePoisson,by="no", all.x=T, sort=F) 

x@data <- temp[order(temp$row),] 

plotvar <- x@data$c2 

str(x@data$c2) 

nclr <- 4 

plotclr <- brewer.pal(nclr,"Blues") 

plotclr <- plotclr[1:nclr] 

class <- classIntervals(plotvar, nclr, style="equal") 

colcode <- findColours(class, plotclr, digits=4) 

plot(x, density=16, col="grey", axes=T, cex.axis=.75) 

plot(x, col=colcode, add=T) 

text(coordinates(x), labels=x$nama_kabupaten_kota, cex=.55) 

title(xlab="x",ylab='y',cex.lab=.75,line=2.25) 

title(main="Area Klaster Jumlah Balita Stunting di Jawa Barat Tahun 2018-2021", sub="Mapped with R",font.sub=2) 