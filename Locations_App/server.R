#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(readr)
library(dplyr)
film_df <- read_csv("~/minor_project2/film_df.csv") # потом будет другой путь! (из общей папки)

#Сделать столбец со странами
library(stringr)
film_df$country <- str_extract(film_df$Location, '\\b[^,]+$')

# список названий фильмов
names <- select (film_df, FilmName)
names1 <- names[!duplicated(names), ]

function(input, output) {
  
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({ input$select })
  
}
