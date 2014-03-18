library(leaflet)
library(shiny)
library(ShinyDash)

shinyUI(fluidPage(
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  leafletMap(
    "map", "100%", 400,
    initialTileLayer = "http://{s}.tile.cloudmade.com/faf72a80fa374ee69a3c64f712c6bf2a/997/256/{z}/{x}/{y}.png",
    initialTileLayerAttribution = HTML('Maps by <a href="http://cloudmade.com//">Mapbox</a>'),
    options=list(
      center = c(37.45, -93.85),
      zoom = 4,
      maxBounds = list(list(17, -180), list(59, 180))
    )
  ),

  fluidRow(
    column(3,
           selectInput("carr", "Choose a Carrier:", 
                       choices = carrier),
           selectInput("airp", "Choose an Airport:", 
                       choices = airport),
           sliderInput("month", "Month:",
                       min = 1, max = 12, value = c(2,5)),
           sliderInput("day1", 
                       "Day of Month:", 
                       min = 1,  max = 31,value = c(1,15)),
           
           sliderInput("day2", 
                       "Day of week:", 
                       min = 1,  max = 7,value = c(2,3))
    ),
    column(4,
           h4('Summary'),
           verbatimTextOutput("summary")
    ),
    column(5,
           plotOutput('plot', width='100%', height='250px')
    )
  )
))