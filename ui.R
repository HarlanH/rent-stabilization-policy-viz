
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
             box(title="asdf", status="primary", width=NULL, "Graph Goes Here"),
             box(title="Supporting Graphs", width=NULL,
                 column(width=6,
                        plotOutput("time_in_unit", height="200px")),
                 column(width=6,
                        plotOutput("final_rent_distribution")))),
      column(width=4,
             box(title="Housing Stock", width=NULL, collapsible=TRUE,
                 sliderInput("num_small", "# Small (5)", min=0, max=1000, value=400, step=100),
                 sliderInput("num_med", "# Medium (25)", min=0, max=1000, value=400, step=100),
                 sliderInput("num_large", "# Large (200)", min=0, max=1000, value=200, step=100)
             ),
             box(title="Population", width=NULL, collapsible=TRUE,
                 sliderInput("mean_years", "Ave. Years", min=1, max=20, value=5, step=1),
                 sliderInput("var_years", "Years Variance", min=0, max=100, value=10)),
             box(title="Economics", width=NULL),
             box(title="Policy", width=NULL),
             actionButton("reset", "Reset"),
             actionButton("run", "Run"))
    )
  ),
  title="Rent Stabilization Policy Simulation"
)
