library(readxl)
library(readr)

#### Download & Save data ####
#download files from OpenDataToronto, there is only .xlsx format availble

### Bus Data ###
#download.file("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/e271cdae-8788-4980-96ce-6a5c95bc6618/resource/7823b829-9952-4e4c-ac8f-0fe2ef53901c/download/ttc-bus-delay-data-2024.xlsx",
#              "data/raw/bus_delay_2024.xlsx", mode = "wb")
bus_delay_2024 <- read.csv("ttc_data/bus-data.csv")



### Streetcar Data ###

#download.file("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/b68cb71b-44a7-4394-97e2-5d2f41462a5d/resource/5f527714-2284-437b-958b-c02b6f21eb9d/download/ttc-streetcar-delay-data-2024.xlsx",
#              "data/raw/streetcar_delay_2024.xlsx", mode = "wb")
streetcar_delay_2024 <- read.csv("ttc_data/streetcar-data.csv")



### Subway Data ###

#download.file("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/996cfe8d-fb35-40ce-b569-698d51fc683b/resource/2ee1a65c-da06-4ad1-bdfb-b1a57701e46a/download/ttc-subway-delay-data-2024.xlsx",
#              "data/raw/subway_delay_2024.xlsx", mode = "wb")
subway_delay_2024 <- read.csv("ttc_data/subway-data.csv")


## Subway Delay Code ##

#download.file("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/996cfe8d-fb35-40ce-b569-698d51fc683b/resource/3900e649-f31e-4b79-9f20-4731bbfd94f7/download/ttc-subway-delay-codes.xlsx", 
#              "data/raw/subway_delay_code.xlsx", mode = "wb")
subway_delay_code <- read.csv("ttc_data/subway-delay-codes.csv")