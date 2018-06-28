data %>%
     select(how_interested_are_you_in_engaging_with_the_alumni_association) %>%
     gather(key = "item", value = "response") %>%
     filter(!is.na(response)) %>%
     mutate(response = ifelse(response == "Somewhat interested" |
                                   response == "Very interested",
                              "Y", "N")) %>%
     group_by(item, response) %>%
     summarize(n = n()) %>%
     
     mutate(pct = round(prop.table(n), 2)) %>%
     filter(response == "Y") %>%
     mutate(group = "All respondents") 
