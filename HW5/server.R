#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
  
  selectedData <- reactive({
    dfSlice <- df %>%
      filter(Seasonality == input$seas, Metro == input$metro)
  })
  
  output$plot1 <- renderPlot({
    
    dfSlice <- df %>%
      filter(Seasonality == input$seas, Metro == input$metro)
    
    ggplot(selectedData(), aes(x = DATE, y = HPI, color = Tier)) +
      geom_line()
  })
  
  output$stats <- renderPrint({
    dfSliceTier <- selectedData() %>%
      filter(Tier == input$tier)
    
    summary(dfSliceTier$HPI)
  })
  
})