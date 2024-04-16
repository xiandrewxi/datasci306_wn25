library(shiny)
library(tidyverse)

ui <- fluidPage(
  
  # Application title
  titlePanel("Reactive List"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton("sing", "Sing!")
    ),
    
    mainPanel(
      htmlOutput("song")
    )
  )
)

server <- function(input, output) {
  ## create a reactive variable that will count the number of times
  ## a user press the "sing!" button subtract that from 99
  ## below
  counter <- reactiveVal(0) 
  counter_out <- eventReactive(input$sing, { 
   0 ## change this
   })
  
  output$song <- renderUI({
    lines <- map(seq(99 - counter_out(), 0),
                 ~ paste("*", .x, "bottles of soda")) |>
      paste(collapse = "\n")
    
    markdown(c("## Everybody sing!", lines))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
