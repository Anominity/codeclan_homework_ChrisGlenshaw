ui <- fluidPage(
  titlePanel(
    title = "Console Game Market"
  ),
  fluidRow(
    sidebarLayout(
      sidebarPanel(
        tabsetPanel(
          tabPanel(
            title = "Options",
            selectInput(
              inputId = "publisher",
              label = "Publisher",
              choices = unique(game_sales$publisher)
            ),
            selectInput(
              inputId = "genre",
              label = "Genre",
              choices = unique(game_sales$genre)
            ),
            radioButtons(
              inputId = "score",
              label = "Score",
              choices = c("Critic", "User")
            ),
            actionButton(
              inputId = "button",
              label = "Execute"
            )
          ),
          tabPanel(
            title = "Aesthetic Settings",
              selectInput(
                inputId = "shape",
                label = "Shape of Points",
                choices = shapes
            )
          )
        )
      ),
      mainPanel(
        fluidRow(
          plotOutput(
            "plot_1"
          ),
        )
      ) 
    )
  )
)
  