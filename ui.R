# Load necessary libraries and source necessary files

library(shiny)
library(plotly)
library(leaflet)
library(shinyWidgets)

source("./analysis.R")
source("./dateplot.R")
source("./barchart.R")

# Create a UI

shinyUI(navbarPage(
  # Create a main tab with the README as information

  "Evictions Data",
  tabPanel(
    "Information",
    fluidRow(
      column(10,
             includeMarkdown("README.md"))
    )
    ),

  # Create a tabPanel to show the scatter plot

  tabPanel(
    "Evictions by Month",

    # Add a titlePanel to the tab
    titlePanel("Evictions by Month Plot"),

    setBackgroundColor(
      color = c("#FFC0CB", "#F0E68C"),
      gradient = "linear",
      direction = "left"
    ),

    # Create a sidebar layout for this tab
    sidebarLayout(

      # Create a sidebarPanel for the controls
      sidebarPanel(

        # Make a textInput widget for searching for a city in the scatter plot
        selectInput("cityvar", "Select a City",
                    choices = c(cities),
                    selected = "Seattle")
      ),

      # Create a main panel to display the plotly Scatter plot
      mainPanel(
        plotlyOutput("by_month_plot")
      )
    )
  ),

  # Create a tab for the bar chart

  tabPanel(
    "Nonpayment of Rent",
    titlePanel("Barchart by Amount of Back Rent"),

    sidebarLayout(

      # Create options for user input based on backrent
      sidebarPanel(
        radioButtons(
          "yes_no",
          "Did the tenant owe greater than one month's rent?",
          choices = list("Yes", "No"),
          selected = "Yes",
          inline = FALSE, width = NULL, choiceNames = NULL,
          choiceValues = NULL)
      ),

      mainPanel(
        plotlyOutput("backrent_chart")
      )
    )
  ),

  # Create tab for the evictions map

  tabPanel(
    "Evictions Map",
    titlePanel("Evictions Mapped by City"),

    sidebarLayout(
   
      # Add a sidebar with legend information

      sidebarPanel(
        h4("Map will take a moment to load after adjusting date range."),
        p("A mapping of evictions by the city they occured in.
          Any level of specificity beyond city could have potentially been a
          breach of privacy"),
        p("The color of the clustered circles corresponds to the amount of
          data points within that cluster. The color of each individual circle
          in each cluster corresponds to the amount of back rent that person
          had when evicted (How far behind on rent they were). The size of each
          circle corresponds to the amount of that individual's one month rent
          divided by 100 (for scaling purposes)"),

        # Create a slider for user input of the date range
        sliderInput(
          inputId = "date_range",
          label = "Date Range",
          min = as.Date("2017-01-01"),
          max = as.Date("2017-12-31"),
          value = c(as.Date("2017-01-01"), as.Date("2017-12-31"))
        )

      ),

      mainPanel(
        leafletOutput("map")
      )
    )
  )
))
