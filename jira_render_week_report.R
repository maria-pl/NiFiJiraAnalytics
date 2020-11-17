Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio-server/bin/pandoc", HOME = "pilipenko")

packages = c("dplyr",
             "tidyr",
             "purrr",
             "lubridate",
             "jsonlite", 
             "httr",
             "stringr",
             "rvest",
             "textutils",
             "gridSVG", 
             "ggplot2",
             "flextable",
             "kableExtra",
             "treemap",
             "officer",
             "rmarkdown")

suppressMessages(
  suppressWarnings(
    ## load packages if exists or install&load 
    package.check <- lapply(
      packages,
      FUN = function(x) {
        if (!require(x, character.only = TRUE)) {
          install.packages(x, dependencies = TRUE)
          library(x, character.only = TRUE)
        }
      }
    )
  )
)

report_meta_data <- commandArgs(trailingOnly = TRUE) # c("start_date", "end_date")

input_issues_data <- readLines(con=file("stdin"), warn=FALSE) %>% fromJSON() # данные за две последние недели

rmarkdown::render('/home/pilipenko/R_scripts/jira_week_html_report.Rmd',  
                  output_file = 'Jira_week_report.html', 
                  output_dir = '/home/pilipenko/R_scripts/reports' , encoding = "UTF-8", quiet = TRUE)


cat(as.character(read_html("/home/pilipenko/R_scripts/reports/Jira_week_report.html", encoding = "UTF-8")))
