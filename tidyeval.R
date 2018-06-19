library(friendlyeval)
library(rlang)


dk_summarize <- function(.data, item, group_col) {
     
     .data %>%
          group_by(!!rlang::ensym(item),
                   !!rlang::ensym(group_col)) %>%
          summarize(n = n()) %>%
          na.omit() %>%
          ungroup() %>%
          group_by(!!rlang::ensym(group_col)) %>%
          mutate(pct = round(prop.table(n), 1)) %>%
          ungroup() %>%
          set_names(c("response", "group", "n", "pct"))
     
     
}


temp <- data %>%
     dk_summarize("prior_to_receiving_the_email_for_this_survey_were_you_aware_of_the_existence_of_the_ford_scholar_alumni_association",
                  "years_since_grad_grouped")


ggplot(temp, 
       aes(x = group, 
           y = pct,
           fill = factor(response))) +
     geom_col() +
     # geom_text(aes(label = n),
     #           hjust = -.5,
     #           color = tfff.dark.green) +
     coord_flip() +
     scale_fill_manual(values = c(tfff.light.green, tfff.dark.green)) +
     dk_theme +
     theme(axis.title = element_blank()) +
     scale_y_continuous(labels = percent)

dk_graph <- function(.data, item, group_col) {
     
     .data %>%
          ggplot(aes(x = rlang::quo_name(rlang::enquo(item)), 
                     y = n)) +
          geom_col(fill = tfff.dark.green) +
          geom_text(aes(label = n),
                    hjust = -.5,
                    color = tfff.dark.green) +
          coord_flip() +
          scale_fill_manual(values = c(tfff.light.green, tfff.dark.green)) +
          dk_theme +
          theme(axis.title = element_blank(),
                axis.text = element_blank()) +
          scale_y_continuous(limits = c(0, 300)) +
          facet_wrap(rlang::quo_name(rlang::enquo(group_col)), ncol = 1)
}



temp <- data %>%
     dk_summarize("prior_to_receiving_the_email_for_this_survey_were_you_aware_of_the_existence_of_the_ford_scholar_alumni_association",
                  "years_since_grad_grouped") 

temp %>%
     dk_graph("prior_to_receiving_the_email_for_this_survey_were_you_aware_of_the_existence_of_the_ford_scholar_alumni_association",
                  "years_since_grad_grouped")

data %>%
     dk_graph("prior_to_receiving_the_email_for_this_survey_were_you_aware_of_the_existence_of_the_ford_scholar_alumni_association",
              )



