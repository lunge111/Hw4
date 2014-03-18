library(leaflet)
library(ggplot2)



# From a future version of Shiny
bindEvent <- function(eventExpr, callback, env=parent.frame(), quoted=FALSE) {
  eventFunc <- exprToFunction(eventExpr, env, quoted)
  
  initialized <- FALSE
  invisible(observe({
    eventVal <- eventFunc()
    if (!initialized)
      initialized <<- TRUE
    else
      isolate(callback())
  }))
}

shinyServer(function(input, output, session) {
  
  makeReactiveBinding('selectedairport')

  
  # Create the map; this is not the "real" map, but rather a proxy
  # object that lets us control the leaflet map on the page.
  map <- createLeafletMap(session, 'map')
  map$addCircle(
    airp$lat,
    airp$long,
    rep(5000,10),
    airp$lat,
    list(
      weight=1.2,
      fill=TRUE,
      color='#4A9'
    )
  )
  observe({
    if (is.null(input$map_click))
      return()
    selectedairport <<- NULL
  })
  


    
  
 
  
  observe({
    event <- input$map_shape_click
    if (is.null(event))
      return()
    map$clearPopups()
    
    
    isolate({

      airport <- airportdat[airportdat$lat == event$id,]
      selectedairport <<- airport
      content <- as.character(tagList(
        tags$strong(paste(airport$airport[1], airport$city[1])),
        tags$br(),
        paste("in, " ,airport$state[1])  
      ))
      map$showPopup(event$lat, event$lng, content, event$id)
    })
  })

data <- reactive({  
  sub(airportdat,input$airp,input$carr,input$month,input$day1,input$day2)
  
  
})
  
output$summary <- renderPrint({
  summary(data())
})
  

  
output$plot <- renderPlot({
  month <- input$month
  day <- input$day
  
  plot(density(data(),na.rm=T))
})
})