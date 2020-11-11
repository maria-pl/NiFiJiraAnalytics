packages = c("dplyr",
             "jsonlite", 
             "httr",
             "stringr"
)

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

input_issues_data <- readLines(con=file("stdin"), warn=FALSE) # данные за всю историю

# Распарсим это дело
input_issues_parsed <- fromJSON(input_issues_data, flatten = TRUE)
jira_issues <- as.data.frame(input_issues_parsed)

# оставим только нужные поля
jira_data <- jira_issues %>% 
  select(key, fields.summary, fields.timespent, fields.created, fields.timeoriginalestimate, fields.description, fields.customfield_10100, fields.aggregatetimespent, fields.resolutiondate, fields.issuetype.name, fields.project.name, fields.priority.name, fields.assignee.displayName, fields.status.name)  %>% 
  rename(fields.issueepic = fields.customfield_10100)

# Отфильтруем только эпики
jira_epics_data <- jira_data %>% filter(fields.issuetype.name =="Epic") %>% 
  select(key, fields.summary, fields.created, fields.resolutiondate, fields.project.name, fields.assignee.displayName, fields.status.name) %>% 
  setNames(c("epic_key", "epic_summary", "created", "epic_resolutiondate", "project_name", "epic_assignee", "epic_status"))

jira_epics_data <- jira_epics_data %>% toJSON(pretty = TRUE)
cat(jira_epics_data)