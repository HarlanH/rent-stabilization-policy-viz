
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Rent Stabilization Policy Simulation"),
  dashboardSidebar(disable=TRUE),
  dashboardBody(
    fluidRow(
      column(width=8,
             box(title="Rent Over Time", status="primary", width=NULL, 
                 plotOutput("rent_over_time")),
             box(title="Supporting Graphs", width=NULL,
                 column(width=6,
                        plotOutput("time_in_unit", height="200px")),
                 column(width=6,
                        plotOutput("final_rent_distribution")))),
      column(width=4,
             box(title="Housing Stock", width=NULL, collapsible=TRUE,
                 sliderInput("num_small", "# Small (5)", min=0, max=100, value=40, step=10),
                 sliderInput("num_med", "# Medium (25)", min=0, max=100, value=40, step=10),
                 sliderInput("num_large", "# Large (200)", min=0, max=100, value=20, step=10)
             ),
             box(title="Population", width=NULL, collapsible=TRUE,
                 sliderInput("mean_years", "Ave. Years", min=1, max=20, value=5, step=1),
                 sliderInput("var_years", "Years Variance", min=0, max=100, value=10)),
             box(title="Economics", width=NULL, collapsible = TRUE,
                 sliderInput("sim_years", "Simulation Years", min=10, max=30, value=20, step=1),
                 sliderInput("inflation", "Inflation", min=0, max=10, value=2.5)),
             box(title="Policy", width=NULL, collapsible = TRUE,
                 sliderInput("std_increase_pct", "Standard Turnover Increase",
                             min=0, max=30, value=10, post="%"),
                 sliderInput("id_max_pct", "Substantially Indentical Max Increase",
                             min=0, max=100, value=30, post="%")),
             actionButton("reset", "Reset"),
             actionButton("run", "Run"))
    )
  ),
  title="Rent Stabilization Policy Simulation"
)
