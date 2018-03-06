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
                  choices = list("Net Generation", "Total Consumption"),
                  selectize = F),
      hr(),
      fluidRow(column(3, verbatimTextOutput("Data Selection"))),
      hr(),
      verbatimTextOutput('out1'),
      selectInput('state', 'Choose a State', c(Choose='', state.name),
                  selectize=FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("dataPlot")
    )
  )
))
