### draw the geographic distribution of samples
feature <- as.matrix(read.table('metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017.txt',head=T,sep='\t',stringsAsFactors=F))
lux <- feature[feature[,3]=='LUX',]
lc <- feature[feature[,3]=='LC',]
pdf('Geo_location.pdf',width=10,height=5)
par(mfrow=c(1,2))
plot(as.numeric(lux[,5]),as.numeric(lux[,6]),col = c('blue','red')[as.factor(lux[,4])],pch=20,main='LUX')
legend(4703750,627250,legend=unique(lux[,4]),col= c('blue','red'), pch=20,cex=0.8)	
plot(as.numeric(lc[,5]),as.numeric(lc[,6]),col = c('blue','red')[as.factor(lc[,4])],pch=20,,main='LC')
legend(4906340,643660,legend=unique(lux[,4]),col= c('blue','red'), pch=20,cex=0.8)	
dev.off()

Loci <- function(x,y){
	loci <- "NaN"
	if(x<4703750) loci <- 'LUX_4'
	if(x > 4703750 & x < 4703850) loci <- 'LUX_3'
	if(x > 4703850 & x < 4800000 & y < 627268)  loci <- 'LUX_2'
	if(x > 4703850 & x < 4800000 & y > 627268)  loci <- 'LUX_1'
	if(y > 643560 & y < 643595)  loci <- 'LC_4'
	if(y > 643595 & y < 643630)  loci <- 'LC_3'
	if(y > 643630 & y < 643660)  loci <- 'LC_2'
	if(y > 643660)  loci <- 'LC_1'
	return(loci)
	}
	
feature <- as.matrix(read.table('metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017.txt',head=T,sep='\t',stringsAsFactors=F))
days <- c()
for(i in 1:nrow(feature)){
	a <- as.numeric(as.Date(feature[i,2], format="%m/%d/%Y")-as.Date(as.character("1/1/2016"), format="%m/%d/%Y")) + 1
	if(a > 365) {
		a <- as.numeric(as.Date(feature[i,2], format="%m/%d/%Y")-as.Date(as.character("1/1/2017"), format="%m/%d/%Y")) + 1
		days <- rbind(days,c(2017,a))
		}
	else{
		days <- rbind(days,c(2016,a))
		}
	}
colnames(days) <- c('Year','Day')
feature <- cbind(feature,days)
location <- c()
for(i in 1:nrow(feature)){
	a <- Loci(as.numeric(feature[i,5]),as.numeric(feature[i,6]))
	location <- c(location,a)
	}
feature <- cbind(feature,location)
write.table(as.matrix(feature),'metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017_locations.txt',col.names=T,row.names=F,sep='\t',quote=F)
