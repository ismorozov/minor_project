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
  titlePanel("Find your perfect place fo go"),
  
  selectInput("select", label = h3("Select film"), 
              choices = list(names1), 
              selected = 1),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"))),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
)
