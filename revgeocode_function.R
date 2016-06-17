reverseGeoCode <- function(latlng) {
  latlngStr <-  gsub(' ','%20', paste(latlng, collapse=","))#Collapse and Encode URL Parameters
  library("RJSONIO") #Load Library
  #Open Connection
  connectStr <- paste('http://maps.google.com/maps/api/geocode/json?sensor=false&latlng=',latlngStr, sep="")
  con <- url(connectStr)
  data.json <- fromJSON(paste(readLines(con), collapse=""))
  close(con)
  #Flatten the received JSON
  data.json <- unlist(data.json)
  if(data.json["status"]=="OK")
    address <- data.json["results.formatted_address"]
  return (address)
}


Zipcode <- rep(NA, nrow(taxitrips1minute))  # make a placeholder
for (i in 1:nrow(taxitrips1minute)) {
  Zipcode[i] <- gsub(" NY ","",unlist(strsplit(reverseGeoCode(c(taxitrips1minute[4,12],taxitrips1minute[4,11])),","))[3])
}


reverseGeoCode(c(taxitrips1minute[2,12],taxitrips1minute[2,11]))
