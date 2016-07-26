nyc <- readOGR("http://catalog.civicdashboards.com/dataset/11fd957a-8885-42ef-aa49-5c879ec93fac/resource/eec14f19-9794-46ef-9bf4-7f6835ffbf4c/download/a5305aa3500748a2b08a6925302f2eednyczipcodetabulationareas.geojson", "OGRGeoJSON")
zips <- nyc$postalCode
tips <- read.csv("http://www.frenett.net/nyc/data/zip_tips_ordered.csv")
zipdata <- read.csv("data/zipdata.csv")
colnames(zipdata) <- c("zip", "pop", "age", "hhincome")
zipdata <- mutate(zipdata, age = as.numeric(as.character(age)), hhincome = as.numeric(as.character(hhincome)))




pdata<- read.csv("http://www.frenett.net/nyc/data/data_2015_by_pickup_zip.csv")
pdata1 <- data.frame(index = 1:262)

pdata1$pickup_zip <- zips

function1 <- connector(count ~ pickup_zip, data=pdata)
pdata1$count <- function1(as.numeric(as.character(zips)))

function2 <- connector(avg_trip_time ~ pickup_zip, data=pdata)
pdata1$avg_trip_time <- function2(as.numeric(as.character(zips)))

function3 <- connector(avg_trip_distance ~ pickup_zip, data=pdata)
pdata1$avg_trip_distance <- function3(as.numeric(as.character(zips)))

function4 <- connector(avg_total_amount ~ pickup_zip, data=pdata)
pdata1$avg_total_amount <- function4(as.numeric(as.character(zips)))

function5 <- connector(avg_tip_amount ~ pickup_zip, data=pdata)
pdata1$avg_tip_amount <- function5(as.numeric(as.character(zips)))






ddata<- read.csv("http://www.frenett.net/nyc/data/data_2015_by_dropoff_zip.csv")
ddata1 <- data.frame(index = 1:262)

ddata1$dropoff_zip <- zips

function1 <- connector(count ~ dropoff_zip, data=ddata)
ddata1$count <- function1(as.numeric(as.character(zips)))

function2 <- connector(avg_trip_time ~ dropoff_zip, data=ddata)
ddata1$avg_trip_time <- function2(as.numeric(as.character(zips)))

function3 <- connector(avg_trip_distance ~ dropoff_zip, data=ddata)
ddata1$avg_trip_distance <- function3(as.numeric(as.character(zips)))

function4 <- connector(avg_total_amount ~ dropoff_zip, data=ddata)
ddata1$avg_total_amount <- function4(as.numeric(as.character(zips)))

function5 <- connector(avg_tip_amount ~ dropoff_zip, data=ddata)
ddata1$avg_tip_amount <- function5(as.numeric(as.character(zips)))


write.csv(pdata1, "data/data_2015_by_pickup_zip_map.csv")
write.csv(ddata1, "data/data_2015_by_dropoff_zip_map.csv")






# create connector function to correctly order tips
function1 <- connector(avg_tip ~ zip, data=tips)
tips <- function1(as.numeric(as.character(zips)))

    # let tips = 0 to be NA，multiply by 100, and round to 2dp
    tips[tips == 0] <- NA
    tips <- tips*100
    tips <- round(tips,2)

# create connector function to correctly order pop
function2 <- connector(pop ~ zip, data=zipdata)
pop <- function2(as.numeric(as.character(zips)))

# create connector function to correctly order age
function3 <- connector(age ~ zip, data=zipdata)
age <- function3(as.numeric(as.character(zips)))
  
# create connector function to correctly order hhincome
function4 <- connector(hhincome ~ zip, data=zipdata)
hhincome <- function4(as.numeric(as.character(zips)))



censusdata <- data.frame(zip = zips, tips = tips, pop = pop, age = age, hhincome = hhincome)

write.csv(censusdata, "data/censusdata.csv")




writeOGR(obj = nyc, dsn = "tempdir", layer ="foo", driver = "ESRI Shapefile",)







