#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

library(readr)
library(dplyr)
film_df <- read_csv("~/minor_project2/film_df.csv")

library(stringr)
film_df$country <- str_extract(film_df$Location, '\\b[^,]+$')

names <- select (film_df, FilmName)
names1 <- names[!duplicated(names), ]

function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- film_df
    if (input$f1 != "All") {
      data <- data[data$FilmName == input$f1,]
    } |
      if (input$f2 != "All") {
        data <- data[data$FilmName == input$f2,]
      } |
      if (input$f3 != "All") {
        data <- data[data$FilmName == input$f3,]
      }
    data
  }))
  
}
