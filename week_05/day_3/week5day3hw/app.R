library(tidyverse)
library(CodeClanData)
library(shiny)
library(bslib)

cattle <- janitor::clean_names(read_csv(
  "data/cattle-registrations-in-scotland-2015-1.csv"))

cattle_choices <- cattle %>% 
  group_by(breed) %>% 
  distinct(breed) %>% 
  arrange(breed) %>% 
  pull()

cattle_full <- cattle %>% 
  group_by(breed, birth_month) %>% 
  mutate(total_births = sum(number_of_births)) %>% 
  ungroup() %>% 
  select(-country, -gov_region, -birth_year, -application_type) %>% 
  group_by(breed, birth_month, breed_type, sex, total_births) %>% 
  distinct(breed)


# ui <- fluidPage(
#   titlePanel(
#     h1("Scottish cattle births in 2015", align = "center")),
#   br(),
#   theme = bs_theme(bootswatch = "flatly"),
#   fluidRow(
#     column(
#       width = 12,
#       plotOutput(
#         "cattle_plot"
#       )
#     )
#   ),
#   br(),
#   fluidRow(
#     column(
#       width = 3,
#       offset = 3,
#       radioButtons(
#         inputId = "breed_type",
#         label = "Non Dairy or Dairy",
#         choices = c("Non Dairy", "Dairy")
#       )
#     ),
#     column(
#       width = 6,
#       selectInput(
#         inputId = "breed",
#         label = "Choose Breed",
#         choices = cattle_choices
#       )
#     )
#   )
# )

ui <- fluidPage(
  titlePanel(
    h1("Scottish cattle births in 2015", align = "center")),
  br(),
  theme = bs_theme(bootswatch = "flatly"),
  fluidRow(
    column(
      width = 12,
      plotOutput(
        "cattle_plot"
      )
    )
  ),
  br(),
  fluidRow(
    column(
      width = 3,
      offset = 3,
      radioButtons(
        inputId = "breed_type",
        label = "Non Dairy or Dairy",
        choices = c("Non Dairy", "Dairy")
      )
    ),
    column(
      width = 6,
      selectInput(
        inputId = "breed",
        label = "Choose Breed",
        choices = NULL
      )
    )
  )
)

server <- function(input, output, session) {
  filtered_breeds <- reactive({
    filter(cattle_full, breed_type == input$breed_type)
  })
  observeEvent(filtered_breeds(), {
    choices <- unique(filtered_breeds()$breed)
    updateSelectInput(inputId = "breed", choices = choices)
  })

# server <- function(input, output, session) {
  output$cattle_plot <- renderPlot(
    cattle_full %>%
      filter(
        breed_type == input$breed_type,
        breed == input$breed
      ) %>%
      ggplot() +
      aes(x = birth_month, y = total_births, fill = sex) +
      geom_col(scale = "identity", position = "dodge") +
      xlab(" ") +
      ylab(" ") +
      scale_fill_manual(values = c("M" = "#0096c7",
                                   "F" = "#f72585")) +
      scale_x_discrete(limits = month.name) +
      theme(panel.background = element_rect(
        fill = 'white', colour = 'white'))
  )
}


shinyApp(ui, server)