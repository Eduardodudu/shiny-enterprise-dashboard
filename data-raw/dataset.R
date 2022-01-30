## code to prepare `dataset` dataset goes here
library(tidyverse)
library(lubridate)
library(xlsx)
library(readxl)
library(htmltools)
library(openxlsx)

# 2 Save Project Data -------------------------------------------------------

# 2.1 Read excel data ---------------------------------------------------
rm(list=ls())

path <- "data-raw/Dataset.xlsx"

Data <- tibble(sheetname = excel_sheets(path)) %>% 
              mutate(data = map(sheetname, ~read_excel(path, sheet = ..1)))

for(i in 1:nrow(Data)) {
  assign(Data[i,]$sheetname, Data[i,]$data[[1]] %>% collect())
}


# 2.2 Assign Values -------------------------------------------------------

# 2.2.1 Constants ---------------------------------------------------------

for(i in 1:nrow(const_vals_df)) {
  assign(const_vals_df[i,]$id, const_vals_df[i,]$value)
}

data_last_day <- as.Date(as.integer(data_last_day), origin = "1899-12-30")
data_first_day <- as.Date(as.integer(data_first_day), origin = "1899-12-30")

colors <- colors_df$value %>% 
          as.list() %>% 
          setNames(colors_df$id)


# 2.2.2 Metrics -----------------------------------------------------------

map_metrics <- map_metrics_df$id

prev_time_range_choices <- time_range_df$value %>% 
                           as.list() %>% 
                           setNames(time_range_df$id)


aux_metrics_list <- metrics_df %>% 
                    pivot_longer(id:invert_colors, names_to = "id_2", values_to = "value") %>% 
                    group_nest(metrics) %>% 
                    mutate(data = map(data, ~..1$value %>% 
                                             as.list() %>% 
                                             setNames(..1$id_2)
                                      )) 


metrics_list <- aux_metrics_list$data %>% 
                setNames(aux_metrics_list$metrics)



# 2.2.3 Data --------------------------------------------------------------

daily_stats <- daily_stats_df

monthly_stats <- monthly_stats_df

yearly_stats <- yearly_stats_df

countries_stats <- countries_stats_df


# 2.3 Save data --------------------------------------------

rm(i,Data,path)
rm(list = ls(pattern = "df|aux"))

save.image("data/constants.RData")







