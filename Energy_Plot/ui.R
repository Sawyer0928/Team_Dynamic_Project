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
  
#Put visulizaiton in one of the two tabs
  navbarPage("United States Energy Statistics",
             tabPanel("Visulization",
                      
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
),

tabPanel("Dropping 2008",
tags$blockquote(
  h3("US Energy Consumption Drops In 2008"),
  tags$hr(),
  tags$img(src = "https://www.llnl.gov/file/24555/download?token=Nl8Decfk", width = "100%",height = "500px"),
  tags$hr(),
  tags$div("According to the visulizations we generated from the ESI database, we can easily find that there is a big drop around year 2008 on each state's general energy consumption."),
  tags$br(),
  tags$div("The main reason we find about this big drop on energy consumption that happens around the nation is because of the spreading utilizations on non-thermal energy sources like solar, wind and hydro."),
  tags$br(),
  tags$div("The big drop that happens in most states results in a shock on prices of the thermal energies we listed in the previous page."),
  tags$br(),
  tags$div("However, petroleum coke can be an outlier who made an increase in several states like Oklahoma and Texas."),
  tags$br(),
  tags$div("The assumption we made about this little anabiosis is probably due to the uncertainty of maintaining the yield of the new energy by existing technology. In which case, since the petroleum coke yields as an by-product in the oil refining process and has relateively lower price, the companies may use the petcokes to make some energy reservations.")
)
  )

)))

