consts <- use("constants.R")

daily_stats <- consts$daily_stats
monthly_stats <- consts$monthly_stats
yearly_stats <- consts$yearly_stats
countries_stats <- consts$countries_stats

server <- function(input, output, session) {
  # browser()
  
  observeEvent(c(input$selected_year), {
    months_choices <-
      getMonthsChoices(input$selected_year, consts$data_last_day)
    selected_month <-
      ifelse(input$selected_month %in% months_choices,
        input$selected_month,
        "0"
      )
    updateSelectInput(session,
      "selected_month",
      selected = selected_month,
      choices = months_choices
    )
  })
  
  observeEvent(c(input$selected_month), {
    if (input$selected_month == "0") {
      updateSelectInput(
        session,
        "previous_time_range",
        choices = consts$prev_time_range_choices["Previous Year"],
        selected = consts$prev_time_range_choices[["Previous Year"]]
      )
    } else {
      updateSelectInput(
        session,
        "previous_time_range",
        choices = consts$prev_time_range_choices,
        selected = input$previous_time_range
      )
    }
  })

  selected_year <- reactive({ input$selected_year })
  selected_month <- reactive({ input$selected_month })
  previous_time_range <- reactive({ input$previous_time_range })

  # Inititalize all modules
  metric_summary$init_server("sales",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("production",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("users",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("complaints",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  time_chart$init_server("time_chart",
                         df = daily_stats,
                         y = selected_year,
                         m = selected_month,
                         previous_time_range = previous_time_range)
  breakdown_chart$init_server("breakdown_chart",
                              df = daily_stats,
                              monthly_df = monthly_stats,
                              yearly_df = yearly_stats,
                              y = selected_year,
                              m = selected_month,
                              previous_time_range = previous_time_range)
  map_chart$init_server("map_chart",
                        df = countries_stats,
                        countries_geo_data = countries_geo_data,
                        y = selected_year,
                        m = selected_month)
}