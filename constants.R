# common variables for generating sample data and shiny app (ui & server)
import("dplyr")
import("htmltools")

#Update spreadsheet
load("data/constants.RData")

#Update those logos with your svg own svg, no need to change any object name.
appsilonLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 660.52 262.96'>
    <use href='assets/icons/icons-sprite-map.svg#appsilon-logo'></use>
  </svg>
")

shinyLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 100 68'>
    <use href='assets/icons/icons-sprite-map.svg#shiny-logo'></use>
  </svg>
")
