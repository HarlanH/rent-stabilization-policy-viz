
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(hexbin)
library(magrittr)

shinyServer(function(input, output) {

  init_state <- reactive({
    message("init_state")
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
  
  all_states <- reactive({ # generates a list of states
    message("all_states")
    # simulate states and accumulate
    state <- init_state()
    accum_states <- list()
    eoy_state <- state
    for (yr in seq_len(input$sim_years)) {
      message("year = ", yr)
      # decrease years to turnover
      eoy_state$yrs_to_turnover <- eoy_state$yrs_to_turnover - 1
      turnover_units <- eoy_state$yrs_to_turnover == 0
      # foreach turnover unit, bump the rent and regenerate years to turnover
      eoy_state$rent[turnover_units] <- eoy_state$rent[turnover_units] * (1 + input$std_increase_pct/100)
      eoy_state$yrs_to_turnover[turnover_units] <- rnbinom(sum(turnover_units),
                                                           size=input$var_years,
                                                           mu=input$mean_years)
      # foreach non-turnover unit, bump the rent
      eoy_state$rent[!turnover_units] <- eoy_state$rent[!turnover_units] * (1+input$infl_increase_pct/100)
      eoy_state$year <- yr
      accum_states[[yr]] <- eoy_state
    }
    accum_states
  })
  
  summarized_states <- reactive({
    message("summarized_states")
    ret <- lapply(all_states(), function(st) {
      select(st, unit_id, year, rent)
    }) %>% rbind_all()
    message("got summarized states; ", nrow(ret), " rows")
    ret
  })
  
  output$rent_over_time <- renderPlot({
    message("rent_over_time")
    if (input$rent_graph_type == "Percentiles") {
      ggplot(summarized_states(), aes(year, rent)) +
        stat_summary(fun.data=median_hilow, geom="ribbon", alpha=.2) +
        stat_summary(fun.data=function(x) median_hilow(x, conf.int=.75), geom="ribbon", alpha=.3) +
        stat_summary(fun.data=median_hilow, color="red", geom="line")
    } else {
      ggplot(summarized_states(), aes(year, rent)) + 
        geom_hex(bins=input$sim_years)
    }
    
  })
  
  output$final_rent_distribution <- renderPlot({
    message("final_rent_distribution")
    ggplot(filter(summarized_states(), year==max(year)), aes(rent)) + geom_histogram(binwidth = 50)
  })
  
  output$time_in_unit <- renderPlot({
    message("time_in_unit")
    ggplot(init_state(), aes(yrs_to_turnover)) + geom_histogram(binwidth=1)
  })

})
