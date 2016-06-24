function(input, output) {
  
  library(mosaic)
  library(knitr)
  library(leaflet)
  library(rjson)
  library(RMySQL)
  library(jsonlite)
  
  con <- dbConnect(MySQL(), dbname = "nyc_taxi", host= "mysql-research.amherst.edu", user="math230", password = "math230pass")
  
  taxitrips1minute <- dbGetQuery(con, "SELECT * FROM trips WHERE pickup_datetime between '2013-01-04 12:00:00' and '2013-01-04 12:01:00'")
  taxitrips1minute <- filter(taxitrips1minute, pickup_longitude!=0)
  
  
  
  
  
  output$map <- renderLeaflet({

    leaflet(data=taxitrips1minute) %>% setView(-73.9,40.71,zoom=11) %>% addProviderTiles("MtbMap") %>%
      addProviderTiles("Stamen.TonerLines",
                       options = providerTileOptions(opacity = 0.35)
      ) %>%
      addProviderTiles("Stamen.TonerLabels")
  })

}