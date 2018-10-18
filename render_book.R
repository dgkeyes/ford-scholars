library(bookdown)


# V1 ----------------------------------------------------------------------

# gitbook(split_by = "section+number", 
#         number_sections = TRUE)
# 
# render_book("overview.Rmd", 
#             "bookdown::gitbook", 
#             output_dir = "report_overview",
#             clean = TRUE)




# V2 ----------------------------------------------------------------------

gitbook(split_by = "section+number", 
        number_sections = TRUE)

render_book("subgroups.Rmd", 
            "bookdown::gitbook", 
            output_dir = "report",
            clean = TRUE)

