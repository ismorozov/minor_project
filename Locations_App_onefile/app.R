
library(shiny)
library(leaflet)
library(ggplot2)

library(readr)
library(dplyr)

library(stringr)
film_df$country <- str_extract(film_df$Location, '\\b[^,]+$')

film_df2 <- film_df %>% select(FilmName, Location, lon, lat)

ui <- fluidPage(
  leafletOutput("mymap"),
  titlePanel("Basic DataTable"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("f1",
                       "Film:",
                       c("All",
                         unique(film_df$FilmName)))
    ) ,
    column(4,
           selectInput("f2",
                       "Location:",
                       c("All",
                         unique(film_df$Location)))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)

server <- function(input, output, session) {
  

  output$table <- DT::renderDataTable(DT::datatable({
    data <- film_df2 
    if (input$f1 != "All") {
      data <- data[data$FilmName == input$f1,]
    } 
    if (input$f2 != "All") {
      data <- data[data$Location == input$f2,]
    } 
    
    d1 <- film_df %>% filter(FilmName == input$f1) # делает (сохраняет) таблицу с одним фильмом и его локациями
    
    data #выдает пользователю таблицу только с фильмами и локациями (чтобы было проще смотреть)
    
  }))
  
    output$mymap <- renderLeaflet({
      d1 <- film_df %>% filter(FilmName == input$f1)
      leaflet() %>%
        addTiles() %>% 
        addMarkers(d1$lon, d1$lat, clusterOptions = markerClusterOptions(), popup = d1$Location)
    
  })
}

shinyApp(ui, server)

