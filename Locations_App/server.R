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
library(leaflet)

library(readr)
library(dplyr)
film_df <- read_csv("~/minor_project2/film_df.csv")

library(stringr)
film_df$country <- str_extract(film_df$Location, '\\b[^,]+$')

film_df2 <- film_df %>% select(FilmName, Location) # короткая база для удобного вывода пользователю

function(input, output, session) {
  
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- film_df2 
    if (input$f1 != "All") {
      data <- data[data$FilmName == input$f1,]
    } 
    if (input$f2 != "All") {
      data <- data[data$Location == input$f2,]
    } 
    
    d1 <- film_df %>% filter(FilmName == input$f1) # делает таблицу с одним фильмом и его локациями
    d2 <- d1 %>% filter(Location == input$f2)
    lon <- d2$lon 
    lat <- d2$lat
    
    data #выдает пользователю таблицу только с фильмами и локациями (чтобы было проще смотреть)
    
  }))
  
  output$mymap <- renderLeaflet({
    d1 <- film_df %>% filter(FilmName == input$f1) # нужно повторить эту строку из прошлой функции, чтобы shiny ее увидел
    leaflet() %>%
      addTiles() %>% 
      addMarkers(d1$lon, d1$lat, clusterOptions = markerClusterOptions(), popup = d1$Location)
    
  })
}


