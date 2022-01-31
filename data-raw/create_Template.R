## code to prepare `dataset` dataset goes here
library(tidyverse)
library(lubridate)
library(xlsx)

# 1. Spreadsheet data -----------------------------------------------------

# 1.1 Get Constants ---------------------------------------------------------------
source("data-raw/old/constants.R")

metrics_df <- unlist(metrics_list, recursive = FALSE) %>% 
  enframe() %>%
  separate(name, sep = "\\.", into = c("metrics","id")) %>% 
  pivot_wider(names_from = id, values_from = value) %>% 
  unnest()


colors_df <- unlist(colors, recursive = FALSE) %>% 
  enframe() %>% 
  rename("id"= name)

time_range_df <- unlist(prev_time_range_choices, recursive = FALSE) %>% 
  enframe()  %>% 
  rename("id"= name)

map_metrics_df <- tibble(id = map_metrics)

const <- ls()[sapply(mget(ls(), .GlobalEnv), is.character)]

const_vals_df <- tibble(id = const) %>% 
  filter(id != "map_metrics") %>% 
  mutate(value = map_chr(id, get))

# 1.2 Get Csvs --------------------------------------------------------------------

daily_stats <- 
  read.csv("data-raw/old/daily_stats.csv", header = TRUE, stringsAsFactors = TRUE) %>%
  mutate(date = ymd(date))

monthly_stats <- read.csv("data-raw/old/monthly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))

yearly_stats <- read.csv("data-raw/old/yearly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))

countries_stats <- read.csv("data-raw/old/countries_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))


# 1.2.1 Create dataset structure -------------------------------------------------------------------

countries <- countries_stats %>% 
  select(iso3,country) %>% 
  distinct_all()

dataset <- tibble(date = seq.Date(as.Date("2015-01-01"), as.Date("2021-12-31"), by = "day")) %>% 
  crossing(countries)

metrics <- c("produced_items","orders_count","revenue","cost","complaints_opened",
             "complaints_closed","users_active","users_dropped_out", "savaged_value")

metrics <- map(metrics, ~rnorm(n = nrow(dataset), 250, 25) %>% as.integer()) %>% 
  setNames(metrics) %>% 
  as_tibble() %>% 
  mutate(profit = revenue - cost + savaged_value)

dataset_df <- dataset %>% 
  cbind(metrics)


# 1.3 Create spreadsheet ------------------------------------------------

dfs <- ls(pattern = "df")

xlsx.writeMultipleData <- function (file, objects) {
  require(xlsx, quietly = TRUE)
  nobjects <- length(objects)
  for (i in 1:nobjects) {
    print(i)
    if (i == 1)
      xlsx::write.xlsx(get(objects[i]), file, sheetName = objects[i])
    else xlsx::write.xlsx(get(objects[i]), file, sheetName = objects[i], 
                    append = TRUE)
  }
}

xlsx.writeMultipleData(objects = dfs, file = "./data-raw/Dataset.xlsx")
