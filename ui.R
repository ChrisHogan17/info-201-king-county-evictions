# ui.R
library(shiny)
library(plotly)

source('./analysis.R')

shinyUI(navbarPage(
  "Evictions Data",
  # Create a tabPanel to show your scatter plot
  tabPanel(
    "Evictions by Month",
    # Add a titlePanel to your tab
    titlePanel("Evictions by Month Plot"),
    
    # Create a sidebar layout for this tab (page)
    sidebarLayout(
      
      # Create a sidebarPanel for your controls
      sidebarPanel(
        
        # Make a textInput widget for searching for a state in your scatter plot
        selectInput("cityvar", "Select a City", 
                    choices = c(cities))
        
      ),
      
      # Create a main panel, display your plotly Scatter plot
      mainPanel(
        plotlyOutput("by_month_plot")
      )
    )
  )
))
