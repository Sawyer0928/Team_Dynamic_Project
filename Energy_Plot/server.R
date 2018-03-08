#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
source("keys.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$dataPlot <- renderPlot({
    category <- input$cat
    state <- input$state
    eiaData <- function(category, state) { #Generates API key
      base <- "http://api.eia.gov/series/?api_key="
      id <- ""
      if(category=="Generation") { #Checks user input
        id <- paste0("ELEC.GEN.ALL-",input$state,"-99.A")
      } else {
        if(input$fuel == "Coal"){ #Checks user input
          id <- paste0("ELEC.CONS_TOT.COW-",input$state,"-99.A")
        } else if (input$fuel == "Petroleum Liquids"){
          id <- paste0("ELEC.CONS_TOT.PEL-",input$state,"-99.A")
        } else if (input$fuel == "Petroleum Coke"){
          id <- paste0("ELEC.CONS_TOT.PC-",input$state,"-99.A")
        } else {
          id <- paste0("ELEC.CONS_TOT.NG-",input$state,"-99.A")
        }
      }
      response <- paste0(base,EiaKey,"&series_id=",id)
      return(response)
    }
    #This call only works if the user inputs 'Generation' or 'Consumption'
    #Made an if statement in case we want to add more user inputs later
    if(category=="Generation"||category=="Consumption"){
      responseData <- GET(eiaData(category, state))
      body <- content(responseData, "text")
      data <- fromJSON(body)
    }
    chartData <-as.data.frame(data$series$data) #turns returned api data into a dataframe
    #x1 should be year and x2 should be the data
    if(input$cat=="Generation") {
      ylab <- "Thousand Megawatthours"
      chartTitle <- paste0("Net Energy Generation for ", input$state)
    } else {
      ylab <- "Thousand Tons"
      chartTitle <- paste0("Consumption of Energy with ", input$fuel," as a Source")
    }
    p <- ggplot(chartData, aes(X1,X2,group=1)) + geom_line() + geom_point() +
      labs(x="Year", y=ylab) + ggtitle(chartTitle) + 
      theme(plot.title = element_text(family="Trebuchet MS", face="bold", size = 20))
    print(p)
  })
  
})
