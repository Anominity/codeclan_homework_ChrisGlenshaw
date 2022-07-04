```{r}
refactor_get_meteorite_count1 <- function(x, meteor_data){
  if (is.numeric(x)){
    if (x %in% meteor_data$year & 
        x < meteor_data %>% arrange(desc(year)) %>% slice_head(n = 1) &
        x > meteor_data %>% arrange(desc(year)) %>% 
        drop_na() %>% slice_tail(n = 1)){
      return(paste("In", x, ",", "there were", 
                   meteor_data %>% 
                     filter(year == x) %>% 
                     count(), 
                   "meteorites."))
    } else {
      return(paste("As far as we know, there were no meteorites that year"))
    }
  } else {
    return(paste("Input must be in numeric format. eg, 2005"))
  }
}

refactor_get_meteorite_count1(2005, meteor_data)
```