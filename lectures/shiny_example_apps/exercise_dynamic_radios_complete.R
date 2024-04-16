library(shiny)
library(ggplot2)
library(tidyverse)

validVars <- select(mpg, where(is.numeric)) |> colnames()
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("MPG Data Variable Selection"),

    sidebarLayout(
        sidebarPanel(
          radioButtons("radio_x", "Choose variable for X-axis", choices = validVars, selected = "cty"),
          radioButtons("radio_y", "Choose variable for Y-axis", choices = validVars, selected = "hwy"),
        ),

        mainPanel(
           plotOutput("mpgPlot")
        )
    )
)

server <- function(input, output) {
  
    ## use events to prevent the user for select the same item in both sets of radio buttons.
    ## use observeEvent() and updateRadioButtons
    ## It helps to set the `selected` argument for `updateRadioButtons` directly
  
    observeEvent(input$radio_x, { updateRadioButtons(inputId = "radio_y", 
                                                     choices = discard(validVars, ~ .x == input$radio_x), 
                                                     selected = input$radio_y)})
    observeEvent(input$radio_y, { updateRadioButtons(inputId = "radio_x", 
                                                     choices = discard(validVars, ~ .x == input$radio_y), 
                                                     selected = input$radio_x)})
    
    output$mpgPlot <- renderPlot({
      ggplot(mpg, aes_string(x = input$radio_x, y = input$radio_y)) + geom_jitter()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
