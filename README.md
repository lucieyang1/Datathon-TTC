# Datathon-TTC

## Overview
This project investigates delays in the 2024 Toronto Transit Commission (TTC) system, including buses, streetcars, and subway lines. The goal is to predict future delays and analyze contributing factors through data cleaning, wrangling, visualization, and modeling.

## Repository Structure
```
Datathon-TTC/
│-- cleaned_data/         # Intermediate processed datasets
│-- ttc_data/             # Original data (provided by organizers)
│-- data_cleaning.R       # Script for initial cleaning and preprocessing data
│-- mapping.Rmd           # Script for more cleaning, and mapping and visualization
```

## External Data

### 1. TTC Stations Coordinate Data from Esri Canada Education
- **Source**: [Esri Canada Education - TTC Stations Coordinates](https://www.arcgis.com/home/item.html?id=05200e06ff524319bde9f16e5955496b)
- **License/terms of use**: Data is public and no special restrictions or limitations specified.
- **Preprocessing steps**: Preprocessed in ArcGIS Pro to extract XY coordinates of subway stations (specific steps documented in [mapping.Rmd](mapping.Rmd)).
- **Justification**: Coordinates were needed to map the data for visualization.

### 2. TTC Subway Lines from Toronto Open Data
- **Source**: [TTC Subway Shapefiles - City of Toronto Open Data Portal](https://open.toronto.ca/dataset/ttc-subway-shapefiles/)
- **License/terms of use**: Data is public and under a Open Government Licence, allowing use under few conditions.
- **Preprocessing steps**: No preprocessing steps, used in [mapping.Rmd](mapping.Rmd).
- **Justification**: For visualization purposes, to add context to our map.

### 3. Daily Data Report from Environment and Climate Change Canada
- **Source**: [Environment and Climate Change Canada - Toronto City Daily Data Report](https://climate.weather.gc.ca/climate_data/daily_data_e.html?hlyRange=2002-06-04%7C2025-02-28&dlyRange=2002-06-04%7C2025-02-28&mlyRange=2003-07-01%7C2006-12-01&StationID=31688&Prov=ON&urlExtension=_e.html&searchType=stnProx&optLimit=specDate&Month=1&Day=6&StartYear=1840&EndYear=2018&Year=2024&selRowPerPage=25&Line=0&txtRadius=25&optProxType=navLink&txtLatDecDeg=43.6275&txtLongDecDeg=-79.396111111111&timeframe=2)
- **License/terms of use**: The data is publicly available through Environment and Climate Change Canada with no restrictions on usage for non-commercial purposes.
- **Preprocessing steps**: Joined data to the TTC data (used in [data_cleaning.R](data_cleaning.R)).
- **Justification**: The daily climate data is helpful for understanding the environmental conditions around the TTC stations, helping to analyze potential relationships between weather patterns and transit delays.

## Other Resources
- Rush Hour from [TTC](https://www.ttc.ca/routes-and-schedules/1/1/13816)
- Holidays from [City of Toronto](https://www.toronto.ca/home/contact-us/statutory-holidays/)
