
# Data --------------------------------------------------------------------

# gs_title("Alumni Engagement Survey Results") %>%
#      gs_download(to = "data/alumni_survey.xlsx",
#                  overwrite = T)

zips <- read_excel("data/TFFF Rural Zip Codes.xlsx") %>%
     clean_names() %>%
     select(-c(zip_code_map, tfff_1_1)) %>%
     remove_empty("rows") %>%
     mutate(zip_code_chr = as.character(zip_code))

data <- read_excel("data/alumni_survey.xlsx") %>%
     clean_names() %>%
     mutate(longitude = as.numeric(longitude)) %>%
     mutate(latitude = as.numeric(latitude)) %>%
     left_join(zips, by = c("what_is_the_zip_code_for_your_current_residence" = "zip_code_chr")) %>%
     mutate(age = 2018 - what_year_were_you_born) %>%
     mutate(lives_in_oregon = ifelse(is.na(tfff_classification), 
                                     "Lives outside Oregon",
                                     "Lives in Oregon")) %>%
     mutate(lives_in_oregon = factor(lives_in_oregon, levels = rev(c("Lives in Oregon",
                                                                 "Lives outside Oregon")))) %>%
     mutate(years_since_grad = 2018 - what_year_did_you_graduate_from_college) %>%
     mutate(years_since_grad_grouped = case_when(
          years_since_grad < 2 ~ "0-2 years",
          years_since_grad < 5 & years_since_grad > 2 ~ "3-5 years",
          years_since_grad < 10 & years_since_grad < 5 ~ "6-10 years",
          years_since_grad < 15 & years_since_grad < 10 ~ "11-15 years",
          TRUE ~ "15+ years"
     )) %>%
     mutate(years_since_grad_grouped = factor(years_since_grad_grouped,
                                              levels = rev(c("0-2 years",
                                                             "3-5 years",
                                                             "6-10 years",
                                                             "11-15 years",
                                                             "15+ years")))) %>%
     mutate(years_since_grad_grouped = fct_rev(years_since_grad_grouped)) %>%
     mutate(highest_level_of_education_completed_or_in_progress = fct_rev(highest_level_of_education_completed_or_in_progress)) %>%
     mutate(rural_or_not = case_when(
          tfff_classification == "Urban" ~ "Urban Oregon",
          tfff_classification == "Rural" ~ "Rural Oregon",
          TRUE ~ "Outside Oregon"
     )) %>%
     mutate(rural_or_not = factor(rural_or_not, levels = c("Rural Oregon",
                                                           "Urban Oregon",
                                                           "Outside Oregon"))) %>%
     mutate(highest_level_of_education_completed_or_in_progress = factor(highest_level_of_education_completed_or_in_progress,
                                                                         levels = c("AA or AS",
                                                                                    "BA, BS, or BSN",
                                                                                    "MA, MS, MAT, MBA, JD",
                                                                                    "PhD, MD",
                                                                                    "Other (please specify)"))) %>%
     mutate(age_groups = case_when(
          age < 30 ~ "20s",
          age < 40 ~ "30s",
          age < 50 ~ "40s",
          age < 60 ~ "50s",
          age < 70 ~ "60s",
          TRUE ~ "No info"
     )) %>%
     mutate(age_groups = factor(age_groups,
                                levels = c("20s",
                                           "30s",
                                           "40s",
                                           "50s",
                                           "60s",
                                           "No info")))


# Theme -------------------------------------------------------------------

tfff.dark.green <- "#265142"
tfff.light.green <- "#B5CC8E"
tfff.orange <- "#e65100"
tfff.yellow <- "#FBC02D"
tfff.blue <- "#283593"
tfff.red <- "#B71C1C"
tfff.brown <- "#51261C"
tfff.dark.gray <- "#545454"
tfff.medium.gray <- "#a8a8a8"
tfff.light.gray <- "#eeeeee"

dk_theme <- theme_minimal() +
     theme(strip.text = element_text(size = 13, face = "bold"),
           panel.spacing = unit(3, "lines"))
