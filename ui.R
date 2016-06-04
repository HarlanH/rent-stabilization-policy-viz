
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Rent Stabilization Policy Simulation"),
  dashboardSidebar(
    disable=TRUE
  ),
  dashboardBody(
    fluidRow(
      column(width=8,
             box(title="Rent Over Time", status="primary", width=NULL,
                 radioButtons("rent_graph_type", "Display As:", c("Percentiles", "Heat Map"),
                              inline=TRUE),
                 plotOutput("rent_over_time"),
                 p("The black line is just the adjustment from $1000 due to the 
                   consumer price index. The red line and shaded areas show the ranges
                   of rents over time -- the red line is the median rent, while the
                   darker grey is the 25th-75th percentiles, and min and max rents.")),
             box(title="Supporting Graphs", width=NULL,
                 column(width=6,
                        plotOutput("time_in_unit", height="200px")),
                 column(width=6,
                        plotOutput("final_rent_distribution", height="200px")))),
      column(width=4,
             box(title="Policy", width=NULL, status="primary",
                 collapsible = FALSE,
                 sliderInput("infl_increase_pct", "Standard Increase",
                             min=0, max=30, value=2.5, step=.5, post="%"),
                 sliderInput("std_increase_pct", "Standard Turnover Increase",
                             min=0, max=30, value=10, post="%"),
                 sliderInput("id_max_pct", "Substantially Indentical Max Increase",
                             min=0, max=100, value=30, post="%"),
                 h3("Policies"),
                 actionButton("policy_default", "Current Policy"),
                 actionButton("policy_lowturnover", "Low Turnover"),
                 actionButton("policy_lowidentical", "Low Indentical Cap")
                 
                 ),
             box(title="Housing Stock", width=NULL, collapsible=TRUE, collapsed = TRUE,
                 sliderInput("num_small", "# Small (5)", min=0, max=100, value=20, step=10),
                 sliderInput("num_med", "# Medium (25)", min=0, max=100, value=20, step=10),
                 sliderInput("num_large", "# Large (200)", min=0, max=100, value=10, step=10)
             ),
             box(title="Population", width=NULL, collapsible=TRUE, collapsed = TRUE,
                 sliderInput("mean_years", "Ave. Years", min=1, max=20, value=5, step=1),
                 sliderInput("var_years", "Years Variance", min=0, max=100, value=10)),
             box(title="Simulation", width=NULL, collapsible = TRUE, collapsed = TRUE,
                 sliderInput("sim_years", "Years", min=10, max=30, value=10, step=1)),
             box(title="About", width=NULL,
                 a("Code for DC Project", href="https://hackpad.com/Rent-Stabilization-Policy-Change-Impact-uLQIb7gQCYZ"),
                 br(), 
                 a("Source", href="https://github.com/codefordc/rent-stabilization"))
      )
    )
  ),
  title="Rent Stabilization Policy Simulation"
)
