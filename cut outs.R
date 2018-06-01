```{r}

data %>%
     select(city, county, tfff_classification, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     mutate(lives_in_oregon = str_replace_na(city, "Oregon")) %>%
     mutate(lives_in_oregon = if_else(lives_in_oregon == "Oregon", "Oregon", "Not in Oregon")) %>%
     group_by(lives_in_oregon, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     count() %>%
     group_by(under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     mutate(pct = round(prop.table(n), digits = 1)) %>%
     ggplot(aes(x = lives_in_oregon, 
                y = n,
                fill = factor(lives_in_oregon))) +
     geom_bar(stat = "identity",
              width = 1) +
     geom_text(aes(label = percent(pct)),
               hjust = -.35,
               color = tfff.dark.gray) +
     # geom_text(aes(label = n),
     #          hjust = 1,
     #          color = "white") +
     # coord_polar("y") +
     coord_flip() +
     scale_y_continuous(limits = c(0, 150),
                        name = "Number") +
     theme_minimal() +
     theme(legend.position = "none",
           axis.title.y = element_blank(),
           panel.grid.minor.x = element_line(color = tfff.light.gray),
           panel.grid.major.x = element_line(color = tfff.light.gray)) +
     scale_fill_manual(values = c(tfff.light.green, tfff.dark.green)) +
     facet_wrap(~under_which_ford_family_program_did_you_receive_your_scholarship,
                ncol = 1)

```