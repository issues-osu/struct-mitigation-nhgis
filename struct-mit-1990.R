library(ipumsr)
library(dplyr)
library(ggplot2)
library(stringr)
library(sf)
library(purrr)
library(stringr)
library(tidyr)
library(gridExtra)
library(RColorBrewer)
library(cmocean)
library(grid) 

set_ipums_api_key("59cba10d8a5da536fc06b59d396db389916641839e5c04f194e1f485")
(nhgis_ds <- get_metadata_nhgis("datasets"))

nhgis_ds |>
  dplyr::filter(str_detect(group, "1990")) |>
  dplyr::select(name, description) |>
  print(n = Inf)

ds_meta <- get_metadata_nhgis(dataset = "1990_STF1")

str(ds_meta, 1)

ds_meta$data_tables |>
  print(n = Inf)

ds_meta$data_tables |>
  filter(str_detect(description, "Poverty"))

ds_meta$data_tables

nhgis_ext <- define_extract_nhgis(
  description = "Households",
  datasets = ds_spec(
    "1990_STF1",
    data_tables = c(
      "NP1", "NP2", "NP3", 
      "NP6", "NP15", "NP16", "NP17", 
      "NP20", "NP21", "NH1", "NH2", "NH3", 
      "NH5", "NH6", "NH30" ),
    geog_levels = "tract"
  )
)



nhgis_ext

nhgis_ext <- submit_extract(nhgis_ext)
nhgis_ext
nhgis_ext <- wait_for_extract(nhgis_ext)
nhgis_files <- download_extract(nhgis_ext)
basename(nhgis_files)
nhgis_data <- read_nhgis(nhgis_files)

nhgis_data_OH <- nhgis_data |>
  dplyr::filter(STATE == "Ohio" & COUNTY == "Hamilton") |>
  dplyr::rename(
    Persons = ET1001, 
    Families = EUD001, 
    Households = EUO001,
    White = EUY001,
    Black = EUY002,
    AIAN = EUY003,
    Asian = EUY004,
    Other = EUY005,
    GRPQTSINST = ET7011,
    GRPQTOTHER = ET7012,
    FHHwchild_noSP = ET8007,
    HUnits = ESA001, 
    Occupied = ESN001,
    Vacant = ESN002,
    OwnerOcc = ES1001,
    RentOcc = ES1002,
    Boarded = ETX001) %>%
  dplyr::select(
    GISJOIN,
    TRACTA,
    Persons  , 
    Families , 
    Households ,
    White ,
    Black ,
    AIAN  ,
    Asian ,
    Other ,
    GRPQTSINST  ,
    GRPQTOTHER ,
    FHHwchild_noSP  ,
    HUnits  , 
    Occupied ,
    Vacant  ,
    OwnerOcc  ,
    RentOcc ,
    Boarded 
  )

colnames(nhgis_data)
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP1")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP2")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP3")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP6")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP15")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NP16")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH1")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH2")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH3")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH5")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH6")
get_metadata_nhgis(dataset = "1990_STF1", data_table = "NH30")

##############################################SF3
ds_meta <- get_metadata_nhgis(dataset = "1990_STF3")

str(ds_meta, 1)

ds_meta$data_tables |>
  print(n = Inf)

ds_meta$data_tables |>
  filter(str_detect(description, "Poverty"))

nhgis_ext <- define_extract_nhgis(
  description = "Poverty",
  datasets = ds_spec(
    "1990_STF3",
    data_tables = c("NP17", "NP57", "NP58", "NP61", "NP80", "NP95", "NH50",
      "NP117", "NP121"),
    geog_levels = "tract"
  )
)

nhgis_ext

nhgis_ext <- submit_extract(nhgis_ext)
nhgis_ext
nhgis_ext <- wait_for_extract(nhgis_ext)
nhgis_files <- download_extract(nhgis_ext)
basename(nhgis_files)
nhgis_data <- read_nhgis(nhgis_files)

colnames(nhgis_data)
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP17")
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP57")
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP58")
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP61")
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP80")
metadata <- get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP80")

print(metadata$variables, n = Inf)

print(metadata$variables, n = Inf)
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP95")
metadata <- get_metadata_nhgis(dataset = "1990_STF3", data_table = "NH50")

print(metadata$variables, n = Inf)
metadata <- get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP117")
print(metadata$variables, n = Inf)
get_metadata_nhgis(dataset = "1990_STF3", data_table = "NP121")
nhgis_data_OH_SF3 <- nhgis_data |>
  dplyr::filter(STATE == "Ohio" & COUNTY == "Hamilton") |>
  dplyr::rename(
    grade9 = E33001,
    grade9to12 = E33002,
    HS = E33003,
    SomeCol = E33004,
    AA = E33005,
    BA = E33006,
    Grad = E33007,
    BLKgrade9 = E34008,
    BLKgrade9to12 = E34009,
    BLKHS = E34010,
    pubast = E5A001,
    nopubast = E5A002,
    LessThan10k_Less20Pct = EY2001,
    LessThan10k_20to24Pct = EY2002,
    LessThan10k_25to29Pct = EY2003,
    LessThan10k_30to34Pct = EY2004,
    LessThan10k_35PctOrMore = EY2005,
    LessThan10k_NotComputed = EY2006,
    TenTo19k_Less20Pct = EY2007,
    TenTo19k_20to24Pct = EY2008,
    TenTo19k_25to29Pct = EY2009,
    TenTo19k_30to34Pct = EY2010,
    TenTo19k_35PctOrMore = EY2011,
    TenTo19k_NotComputed = EY2012,
    TwentyTo34k_Less20Pct = EY2013,
    TwentyTo34k_20to24Pct = EY2014,
    TwentyTo34k_25to29Pct = EY2015,
    TwentyTo34k_30to34Pct = EY2016,
    TwentyTo34k_35PctOrMore = EY2017,
    TwentyTo34k_NotComputed = EY2018,
    ThirtyFiveTo49k_Less20Pct = EY2019,
    ThirtyFiveTo49k_20to24Pct = EY2020,
    ThirtyFiveTo49k_25to29Pct = EY2021,
    ThirtyFiveTo49k_30to34Pct = EY2022,
    ThirtyFiveTo49k_35PctOrMore = EY2023,
    ThirtyFiveTo49k_NotComputed = EY2024,
    FiftyKPlus_Less20Pct = EY2025,
    FiftyKPlus_20to24Pct = EY2026,
    FiftyKPlus_25to29Pct = EY2027,
    FiftyKPlus_30to34Pct = EY2028,
    FiftyKPlus_35PctOrMore = EY2029,
    FiftyKPlus_NotComputed = EY2030,
  
    income_Less5k = E4T001,
    income_5kto10k = E4T002,
    income_10kto12_5k = E4T003,
    income_12_5kto15k = E4T004,
    income_15kto17_5k = E4T005,
    income_17_5kto20k = E4T006,
    income_20kto22_5k = E4T007,
    income_22_5kto25k = E4T008,
    income_25kto27_5k = E4T009,
    income_27_5kto30k = E4T010,
    income_30kto32_5k = E4T011,
    income_32_5kto35k = E4T012,
    income_35kto37_5k = E4T013,
    income_37_5kto40k = E4T014,
    income_40kto42_5k = E4T015,
    income_42_5kto45k = E4T016,
    income_45kto47_5k = E4T017,
    income_47_5kto50k = E4T018,
    income_50kto55k = E4T019,
    income_55kto60k = E4T020,
    income_60kto75k = E4T021,
    income_75kto100k = E4T022,
    income_100kto125k = E4T023,
    income_125kto150k = E4T024,
    income_150kplus = E4T025,
    # Renaming income in 1989 variables
    income1989_above_poverty_under5 = E07001,
    income1989_above_poverty_5years = E07002,
    income1989_above_poverty_6to11 = E07003,
    income1989_above_poverty_12to17 = E07004,
    income1989_above_poverty_18to24 = E07005,
    income1989_above_poverty_25to34 = E07006,
    income1989_above_poverty_35to44 = E07007,
    income1989_above_poverty_45to54 = E07008,
    income1989_above_poverty_55to59 = E07009,
    income1989_above_poverty_60to64 = E07010,
    income1989_above_poverty_65to74 = E07011,
    income1989_above_poverty_75plus = E07012,
    income1989_below_poverty_under5 = E07013,
    income1989_below_poverty_5years = E07014,
    income1989_below_poverty_6to11 = E07015,
    income1989_below_poverty_12to17 = E07016,
    income1989_below_poverty_18to24 = E07017,
    income1989_below_poverty_25to34 = E07018,
    income1989_below_poverty_35to44 = E07019,
    income1989_below_poverty_45to54 = E07020,
    income1989_below_poverty_55to59 = E07021,
    income1989_below_poverty_60to64 = E07022,
    income1989_below_poverty_65to74 = E07023,
    income1989_below_poverty_75plus = E07024,
   
    range_under_50 = E1C001,
    range_50_to_74 = E1C002,
    range_75_to_99 = E1C003,
    range_1_to_124 = E1C004,
    range_125_to_149 = E1C005,
    range_150_to_174 = E1C006,
    range_175_to_184 = E1C007,
    range_185_to_199 = E1C008,
    range_2_and_over = E1C009
  ) |>
  dplyr::select(
    GISJOIN,
    TRACTA,
    grade9,
    grade9to12,
    HS,
    SomeCol,
    AA,
    BA,
    Grad,
    BLKgrade9,
    BLKgrade9to12,
    BLKHS,
    pubast,
    nopubast,
    starts_with("LessThan10k"),
    starts_with("TenTo19k"),
    starts_with("TwentyTo34k"),
    starts_with("ThirtyFiveTo49k"),
    starts_with("FiftyKPlus"),
    income_Less5k,
    income_5kto10k,
    income_10kto12_5k,
    income_12_5kto15k,
    income_15kto17_5k,
    income_17_5kto20k,
    income_20kto22_5k,
    income_22_5kto25k,
    income_25kto27_5k,
    income_27_5kto30k,
    income_30kto32_5k,
    income_32_5kto35k,
    income_35kto37_5k,
    income_37_5kto40k,
    income_40kto42_5k,
    income_42_5kto45k,
    income_45kto47_5k,
    income_47_5kto50k,
    income_50kto55k,
    income_55kto60k,
    income_60kto75k,
    income_75kto100k,
    income_100kto125k,
    income_125kto150k,
    income_150kplus,
    income1989_above_poverty_under5,
    income1989_above_poverty_5years,
    income1989_above_poverty_6to11,
    income1989_above_poverty_12to17,
    income1989_above_poverty_18to24,
    income1989_above_poverty_25to34,
    income1989_above_poverty_35to44,
    income1989_above_poverty_45to54,
    income1989_above_poverty_55to59,
    income1989_above_poverty_60to64,
    income1989_above_poverty_65to74,
    income1989_above_poverty_75plus,
    income1989_below_poverty_under5,
    income1989_below_poverty_5years,
    income1989_below_poverty_6to11,
    income1989_below_poverty_12to17,
    income1989_below_poverty_18to24,
    income1989_below_poverty_25to34,
    income1989_below_poverty_35to44,
    income1989_below_poverty_45to54,
    income1989_below_poverty_55to59,
    income1989_below_poverty_60to64,
    income1989_below_poverty_65to74,
    income1989_below_poverty_75plus,
    range_under_50,
    range_50_to_74,
    range_75_to_99,
    range_1_to_124,
    range_125_to_149,
    range_150_to_174,
    range_175_to_184,
    range_185_to_199,
    range_2_and_over
  )



nhgis_combined <- nhgis_data_OH_SF3 %>%
  inner_join(nhgis_data_OH, by = "GISJOIN")

roads <- tigris::roads(state = "OH", county = "Hamilton", year = 2011)

roads_sf <- st_as_sf(roads)
#st_write(roads_sf, "C:/Users/barboza-salerno.1/Downloads/major_roads_hamilton.shp")

dat <- st_read("D:/projects/eric-long/data/shapefiles/1990_hamilton_tracts_ohio.shp") %>% dplyr::filter(COUNTY == "061") %>%
  left_join(nhgis_combined)

names(dat)

#st_write(dat, "D:/projects/eric-long/data/nhgis_dat_spatial.geojson")

nhgis1990 <- st_read("D:/projects/eric-long/data/nhgis_dat_spatial.geojson")

nhgis1990 <- nhgis1990 %>%
  mutate(across(c(Black, White, income1989_above_poverty_under5, FHHwchild_noSP, Boarded, pubast), 
                ~replace(., . < 0, NA)))

color_palette <- brewer.pal(9, "YlGnBu")  # Example of a blue-green palette from RColorBrewer

p1 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = Black)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "Black Population", fill = "Percent Black") +
  theme_void() +
  theme(legend.position = "bottom")


p2 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = White)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "White Population", fill = "Percent White") +
  theme_void() +
  theme(legend.position = "bottom")

p3 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = income1989_above_poverty_under5)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "Child Poverty", fill = "Percent Unemployed") +
  theme_void() +
  theme(legend.position = "bottom")

p4 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = FHHwchild_noSP)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "Female HH no Spouse (child)", fill = "Percent Disabled") +
  theme_void() +
  theme(legend.position = "bottom")

p5 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = Boarded)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "Boarded Homes", fill = "Percent Professional") +
  theme_void() +
  theme(legend.position = "bottom")

p6 <- ggplot(nhgis1990) +
  geom_sf(aes(fill = pubast)) +
  scale_fill_gradientn(colors = color_palette,  na.value = "white") +
  labs(title = "Public Assistance", fill = "Percent Below Poverty") +
  theme_void() +
  theme(legend.position = "bottom")


grid.arrange(
  p1, p2, p3, p4, p5, p6, 
  ncol = 3,
  top = grid::textGrob(
    "Neighborhood Social and Economic Conditions (1990)",
    gp = grid::gpar(fontsize = 16, fontface = "bold")
  )
)

