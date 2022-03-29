library(shiny)
library(tidyverse)
library(babynames)    

ui <- fluidPage(textInput(inputId = "name", 
                          label = "Name:", 
                          value = "", 
                          placeholder = "Enter Name Here"), 
                sliderInput(inputId = "years", 
                            label = "Years", 
                            min = 1880, 
                            max = 2017, 
                            value = c(1880, 2017), 
                            sep = ""),
                selectInput(inputId = "sex",
                            label = "Sex", 
                            choices = c("Male" = "M", "Female" = "F")), 
                submitButton(text = "Create Plot"), 
                plotOutput(outputId = "timeplot"))

server <- function(input, output) {
  output$timeplot <- renderPlot(
    babynames %>% 
      filter(sex == input$sex,
             name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_line() +
      scale_x_continuous(limits = input$years)
  )
}
shinyApp(ui = ui, server = server)