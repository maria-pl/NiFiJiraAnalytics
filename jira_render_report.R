packages = c("dplyr",
             "tidyr",
             "purrr",
             "lubridate",
             "jsonlite", 
             "httr", 
             "gridSVG", 
             "ggplot2",
             "flextable",
             "kableExtra",
             "treemap",
             "officer")

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

rmarkdown::render('/home/mpilipenko/Jira_analytics_html.Rmd',  
                  output_file = 'Jira_analytics.html', 
                  output_dir = '/home/mpilipenko/reports' , encoding = "UTF-8")
