#

library(shiny)

#states = readRDS(file = paste(path,'/MapShiftingClimates/stateList.rds',sep=""))

states = readRDS(file = 'Data/stateList.rds')
states = data.frame(states,row.names = states)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Future Climates of the US States"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("state", label = h4("States:"),choices = as.character(states[,1])
      ),
      checkboxGroupInput("years", h5("When:"),
                         choices=c("Current" = "whrCU",
                                   "2050"    = "whr50I",
                                   "2070"    = "whr70I"),
                         selected = c("whrCU","whr50I","whr70I"),
                         inline = TRUE                           
      ), 
      checkboxGroupInput("rcp", h5("RCPs:"),
                         choices=c("2.6" = "rcp26",
                                   "4.5"    = "rcp45",
                                   "6.0"    = "rcp60",
                                   "8.5"    = "rcp85"),
                         selected = c("rcp60"),
                         inline = TRUE                           
      )  
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("map")
    )
  )
))


#5c8ea9ca81cd5e18

