## code to prepare `dataset` dataset goes here
library(tidyverse)
library(lubridate)
library(xlsx)
library(readxl)
library(htmltools)
library(openxlsx)

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

daily_stats_df <- 
  read.csv("data-raw/daily_stats.csv", header = TRUE, stringsAsFactors = TRUE) %>%
  mutate(date = ymd(date))

monthly_stats_df <- read.csv("data-raw/monthly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))

yearly_stats_df <- read.csv("data-raw/yearly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))

countries_stats_df <- read.csv("data-raw/countries_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))


# 1.3 Create spreadsheet ------------------------------------------------

dfs <- ls(pattern = "df")

xlsx.writeMultipleData <- function (file, objects) {
  require(xlsx, quietly = TRUE)
  nobjects <- length(objects)
  for (i in 1:nobjects) {
    print(i)
    if (i == 1)
      write.xlsx(get(objects[i]), file, sheetName = objects[i])
    else write.xlsx(get(objects[i]), file, sheetName = objects[i], 
                    append = TRUE)
  }
}

xlsx.writeMultipleData(objects = dfs, file = "./data-raw/Dataset.xlsx")
