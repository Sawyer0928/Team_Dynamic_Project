#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("United States Energy Statistics"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("cat", "Data Selection", 
                  choices = list("Generation", "Consumption")),
      conditionalPanel(
        condition = "input.cat == 'Consumption'",
        selectInput("fuel", "Fuel Type",
                    choices = list("Coal", "Petroleum Liquids", "Petroleum Coke",
                                   "Natural Gas"))
      ),
      hr(),
      fluidRow(column(3, verbatimTextOutput("Data Selection"))),
      hr(),
      verbatimTextOutput('out1'),
      selectInput('state', 'Choose a State', state.abb,
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("dataPlot")
    )
  )
))
