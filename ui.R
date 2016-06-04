
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
             box(title="asdf", status="primary", width=NULL, "Graph Goes Here")),
      column(width=4,
             box(title="Housing Stock", width=NULL),
             box(title="Population", width=NULL),
             box(title="Economics", width=NULL),
             box(title="Policy", width=NULL),
             actionButton("reset", "Reset"))
    )
  ),
  title="Rent Stabilization Policy Simulation"
)
