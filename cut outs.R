# Demographics across variables

## Within Oregon vs outside of Oregon

### By scholarship type

```{r}

data %>%
     select(city, county, tfff_classification, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     mutate(lives_in_oregon = str_replace_na(city, "Not in Oregon")) %>%
     mutate(lives_in_oregon = if_else(lives_in_oregon == "Not in Oregon", "Not in Oregon", "Oregon")) %>%
     group_by(lives_in_oregon, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     count() %>%
     group_by(under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     mutate(pct = round(prop.table(n), digits = 2)) %>%
     ungroup() %>%
     mutate(lives_in_oregon = fct_rev(lives_in_oregon)) %>%
     ggplot(aes(x = "", 
                y = pct,
                fill = factor(lives_in_oregon))) +
     geom_bar(stat = "identity",
              width = 1) +
     geom_text(aes(label = percent(pct)),
               position = position_stack(vjust = 0.5),
               color = "white") +
     coord_polar("y") +
     theme_void() +
     theme(legend.position = "bottom") +
     labs(fill = "") +
     facet_wrap(~under_which_ford_family_program_did_you_receive_your_scholarship) +
     scale_fill_manual(values = c(tfff.dark.green, tfff.light.green))


```

## Rural

### Rural vs not rural by type of scholarship

```{r}

data %>%
     select(tfff_classification, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     filter(!is.na(tfff_classification)) %>%
     group_by(tfff_classification, under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     count() %>%
     ungroup() %>%
     group_by(under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     mutate(pct = round(prop.table(n), digits = 2)) %>%
     ungroup() %>%
     ggplot(aes(x = "", 
                y = pct,
                fill = factor(tfff_classification))) +
     geom_bar(stat = "identity",
              width = 1) +
     geom_text(aes(label = percent(pct)),
               position = position_stack(vjust = 0.5),
               color = "white") +
     coord_polar("y") +
     theme_void() +
     theme(legend.position = "bottom") +
     labs(fill = "") +
     facet_wrap(~under_which_ford_family_program_did_you_receive_your_scholarship) +
     scale_fill_manual(values = c(tfff.light.green, tfff.dark.green))
```






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




double_col <- function(dat, arg){
     mutate(dat, result = !!treat_input_as_col(arg) * 2)
}

## working call form:
double_col(mtcars, cyl)


reverse_group_by <- function(dat, ...){
     ## this expression is split out for readability, but it can be nested into below.
     groups <- treat_inputs_as_cols(...)
     
     group_by(dat, !!!rev(groups))
}

## working call form
reverse_group_by(mtcars, gear, am)
```{r}



```

data %>%
     select(c(contains("which_communications"), age_groups)) %>%
     set_names(c("Quarterly e-newsletter",
                 "Annual alumni magazine",
                 "Emails",
                 "Social media posts",
                 "None",
                 "age_groups")) %>%
     gather(key = "item", value = "response", -age_groups) %>%
     mutate(response = str_replace_na(response, "No")) %>%
     mutate(response = ifelse(response == "No", "No", "Yes")) %>%
     group_by(item, age_groups) %>%
     count(response) %>%
     mutate(pct = round(prop.table(n), digits = 2)) %>%
     ungroup() %>%
     mutate(item = factor(item, levels = rev(c("Quarterly e-newsletter",
                                               "Annual alumni magazine",
                                               "Emails",
                                               "Social media posts",
                                               "None")))) %>%
     filter(response == "Yes") %>%
     ggplot(aes(x = item, y = pct)) +
     geom_col(fill = tfff.dark.green) +
     geom_text(aes(label = percent(pct)),
               hjust = -.35,
               color = tfff.dark.green) +
     coord_flip() +
     dk_bar_chart_theme +
     scale_y_continuous(labels = percent,
                        limits = c(0, 1.5)) +
     facet_wrap(~age_groups)