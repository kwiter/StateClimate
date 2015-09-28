
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(maps)

allWHR = readRDS(file ='Data/allWHR2_noAM.rds')
cliCoor = readRDS(file = 'Data/cliCoor_noAm.rds')
ext = readRDS(file = 'Data/extent.rds')

plotClim = function(sts = 'North Carolina',when =  c("whrCU","whr50I",'whr70I')){
  whrST = which(allWHR$state == sts & (allWHR$type %in% when))
  if(length(whrST) == 0) whrST = 1
  whr = a.n(a.c(allWHR[whrST,'whr']))
  colors = c("#EDC951","#CC333F","#00A0B0","#6A4A3C","#EB6841")
  colours = rep(NA,len(whrST))
  for(i in 1:len(whrST)){
   colours[i] = adjustcolor(colors[a.n(as.factor(allWHR[whrST[i],'type']))], alpha.f = allWHR[whrST[i],'abund'])
    #if(colours[i] < .1){colours[i] = adjustcolor(colors[a.n(as.factor(allWHR[whrST[i],'type']))], alpha.f = 0)}
  }

  #ext@xmax = -40
  #ext@xmin = -135 
  #ext@ymax = 52
  #ext@ymin = 25  #25
  par(mar=c(2,2,2,1), oma=c(0,0,0,0), bg="white", xpd=FALSE, xaxs="r", yaxs="i", mgp=c(2.1,.3,0), las=1, col.axis="#434343", col.main="#343434", tck=0, lend=1)
  plot(ext, type="n", bty="n", las=1,
     xlab='', ylab='', family="Helvetica", cex.main=1.5, cex.axis=0.8, cex.lab=0.8, xaxt="n", yaxt="n")
  map(,add=T,col=1)
  map('state',add=T,col='black')
  points(cliCoor[whr,1],cliCoor[whr,2],col=colours,pch=20,cex=.75)

  legend(-62,34,c("Current","2050","2070"),fill=c("#00A0B0","#EDC951","#CC333F"),border='white',bty='n') #us ledgend
  title(paste("The climate of", sts, "from today to 2070",line=0))
  map('state',add=T,col=rgb(.8,.8,.8,.5))

  #legend(47,-30,c("Current","2050","2070"),fill=c("#00A0B0","#EDC951","#CC333F"))
}

shinyServer(function(input, output) {

  output$map <- renderPlot({
    # Render a plot
    plotClim(input$state,input$years)
    
  })

})
