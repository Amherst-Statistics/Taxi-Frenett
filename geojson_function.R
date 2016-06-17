library(jsonlite)

# From http://data.okfn.org/data/datasets/geo-boundaries-world-110m
geojson <- readLines("http://catalog.civicdashboards.com/dataset/11fd957a-8885-42ef-aa49-5c879ec93fac/resource/eec14f19-9794-46ef-9bf4-7f6835ffbf4c/download/a5305aa3500748a2b08a6925302f2eednyczipcodetabulationareas.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

# Default styles for all features
geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 1,
  fillOpacity = 0.8
)

# Gather GDP estimate from all countries
zip <- sapply(geojson$features, function(feat) {
  as.numeric(feat$properties$postalCode)
})
# Gather population estimate from all countries
pop_est <- sapply(geojson$features, function(feat) {
  max(1, feat$properties$pop_est)
})

# Color by per-capita GDP using quantiles
pal <- colorQuantile("Greens", zip, n=10)
# Add a properties$style list to each feature
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style <- list(
    fillColor = pal(
      as.numeric(feat$properties$postalCode)
    )
  )
  feat
})

# Add the now-styled GeoJSON object to the map
leaflet() %>% addGeoJSON(geojson)