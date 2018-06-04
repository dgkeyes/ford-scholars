gitbook(split_by = "section+number", 
        number_sections = TRUE)

render_book("ford_scholar_alumni_survey.Rmd", 
            "bookdown::gitbook", 
            output_dir = "report",
            clean = TRUE)
