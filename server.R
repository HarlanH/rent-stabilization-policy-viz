
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  init_state <- reactive({
    # generate a data frame of units
    units <- data.frame(bld_id=c(rep(seq.int(from=1000, length.out=input$num_small), 5),
                        rep(seq.int(from=2000, length.out=input$num_med), 25),
                        rep(seq.int(from=3000, length.out=input$num_large), 200)),
                        rent=1000)
    units$unit_id <- seq_len(nrow(units))
    units$yrs_to_turnover <- rnbinom(input$num_small+input$num_med+input$num_large,
                                     size=input$var_years,
                                     mu=input$mean_years)
    units
  })
  output$time_in_unit <- renderPlot({
    ggplot(init_state(), aes(yrs_to_turnover)) + geom_histogram(binwidth=1)
  })

})
