### By subgroup: Lives in Oregon

```{r fig.width = 12, fig.height = dk_height * 2}
dk_summarize_work_multiple(lives_in_oregon) %>%
     dk_plot_work()

```

### By subgroup: Rural

```{r fig.width = 12, fig.height = dk_height * 4}
dk_summarize_work_multiple(rural_or_not) %>%
     dk_plot_work()

```


### By subgroup: Years since graduation

```{r fig.width = 12, fig.height = dk_height * 5}
dk_summarize_work_multiple(years_since_grad_grouped) %>%
     dk_plot_work()

```


### By subgroup: Highest level of education

```{r fig.width = 12, fig.height = dk_height * 5}
dk_summarize_work_multiple(highest_level_of_education_completed_or_in_progress) %>%
     dk_plot_work()

```


### By subgroup: Age

```{r fig.width = 12, fig.height = dk_height * 5}
dk_summarize_work_multiple(age_groups) %>%
     dk_plot_work()

```


### By subgroup: Scholarship type

```{r fig.width = 12, fig.height = dk_height * 4}
dk_summarize_work_multiple(under_which_ford_family_program_did_you_receive_your_scholarship) %>%
     dk_plot_work()

```






