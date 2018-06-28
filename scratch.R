data %>%
     select(contains("reasons_for_engaging")) %>%
     select(-reasons_for_engaging_with_alumni_assocation_is_there_anything_not_listed_in_question_13_that_would_motivate_you_to_participate_in_alumni_activities) %>%
     set_names(c("Professional networking",
                 "Community service",
                 "Building community",
                 "Leadership development",
                 "Connection to and support of TFFF")) %>%
     gather(key = "item", value = "response") %>%
     mutate(response = 6 - response) %>%
     group_by(item) %>%
     summarize(avg = round(mean(response, na.rm = TRUE), 1)) %>%
     mutate(group = "All respondents")
