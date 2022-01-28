# Load utility functions
source("utilities/getTimeFilterChoices.R")
source("utilities/getMetricsChoices.R")
source("utilities/getExternalLink.R")

# Load constant variables
consts <- use("constants.R")

# Html template used to render UI
htmlTemplate(
  "www/index.html",
  appTitle = consts$app_title,
  appVersion = consts$app_version,
  mainLogo = getExternalLink("https://appsilon.com/", "main", consts$appsilonLogo),
  dashboardLogo = getExternalLink("https://shiny.rstudio.com/", "dashboard", consts$shinyLogo),
  selectYear = selectInput(
    "selected_year", "Year",
    choices = getYearChoices(consts$data_first_day, consts$data_last_day),
    selectize = TRUE
  ),
  selectMonth = selectInput(
    "selected_month", "Month",
    choices = getMonthsChoices(year = NULL, consts$data_last_day),
    selected = month(consts$data_last_day),
    selectize = TRUE
  ),
  previousTimeRange = selectInput(
    "previous_time_range", "Compare to",
    choices = consts$prev_time_range_choices,
    selected = "prev_year",
    selectize = TRUE
  ),
  salesSummary = metric_summary$ui("sales"),
  productionSummary = metric_summary$ui("production"),
  usersSummary = metric_summary$ui("users"),
  complaintsSummary = metric_summary$ui("complaints"),
  timeChart = time_chart$ui("time_chart"),
  breakdownChart = breakdown_chart$ui("breakdown_chart"),
  countryMap = map_chart$ui("map_chart"),
  marketplace_website = consts$marketplace_website
)
