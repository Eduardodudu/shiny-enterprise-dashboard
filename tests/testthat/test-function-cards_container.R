library(testthat)
library(dplyr)

test_that("cards_container works", {

  names <- "WIDTH"
  description <- data_description[data_description$ID %in% names, ]
  
  cards <- marine_dataset %>% 
           cards_container(., description$ID, description$Description,
                          description$icon, description$label)
  
  cards %>% 
    expect_type("list") %>%
    expect_s3_class("shiny.tag")

})
