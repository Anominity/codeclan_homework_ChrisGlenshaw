server <- function(input, output, session) {
  filter_games_sales <- eventReactive(
    input$button,
    game_sales %>% 
      filter(genre == input$genre,
             publisher == input$publisher)
  )

  output$plot_1 <- renderPlot( 
    if(input$score == "Critic") {
    filter_games_sales() %>% 
      ggplot() +
      aes(x = year_of_release, y = critic_score, label = name) +
      geom_point(aes(colour = name),
                 show.legend = "none",
                 shape = as.numeric(input$shape),
                 size = 3) +
      labs(x = "Release Year", y = "Critic Score")# +
   #   geom_text(hjust=0.2, vjust=-0.1)
                   
  } else 
    
    if(input$score == "User")
      filter_games_sales() %>% 
    ggplot() +
    aes(x = year_of_release, y = user_score, label = name) +
    geom_point(aes(colour = name),
               show.legend = "none",
               shape = as.numeric(input$shape),
               size = 3) +
    labs(x = "Release Year", y = "User Score")# +
 #   geom_text(hjust=0.2, vjust=-0.1)
  )
  # 
  # 
  # output$plot_2 <- renderPlot(
  #   filter_games_sales() %>% 
  #     ggplot() +
  #     aes(x = year_of_release, y = critic_score) +
  #     geom_point(aes(colour = name),
  #                show.legend = "none",
  #                shape = as.numeric(input$shape)) +
  #     labs(x = "Release Year", y = "Critic Score")
  # )
  # 
  
  
}