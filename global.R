library(lubridate)
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
library(scales)
library(glue)
library(leaflet)
library(skimr)
library(countrycode)
library(shiny)
library(shinydashboard)
library(sf)
library(rgeos)
library(ggspatial)
library(rworldmap)

data <- read.csv("master.csv")

suicide <- data %>%
  select(-(HDI.for.year),-(country.year),-(gdp_for_year....),-(gdp_per_capita....),-(generation)) %>%
  setNames(c("country",
             "year",
             "sex",
             "group_age",
             "suicides_numbers",
             "population",
             "suicides_rate")
  ) %>% 
  mutate(country=as.factor(country),
         country_code=countrycode(country,origin="country.name",destination="iso3c"),
         continent=as.factor(countrycode(country,origin="country.name",destination = "continent")),
         year=as.numeric(year),
         sex=as.factor(sex),
        date_year=year(as.Date(as.character(year),format="%Y")),
         group_age=as.factor(group_age)
  ) %>% filter(year!=2016) %>% filter(country!="Dominica") %>% filter(country!="Saint Kitts and Nevis") %>% 
  filter(country!="Macau") %>% filter(country!="Cabo Verde") %>% mutate(tahun=as.factor(year))




