# dependency
library(jsonlite)

parse_issue_json_to_csv <- function(repos_owner,
                                    repos_name,
                                    outfile = paste0(getwd(), "/", "github_issues_",
                                                     gsub(Sys.time(), pattern = " ", replacement = "_"),
                                                     ".csv")) {

  link <- paste0("https://api.github.com/repos/", repos_owner, "/", repos_name, "/issues")
  message(paste0("The link is: ", link))

  # parse issues
  issues <- fromJSON(link)
  # retain relevant columns
  issues_relevant <- issues[, c("title", "number", "body", "created_at", "updated_at", "html_url")]

  issue_labels_list <- issues$labels
  # init
  issue_labels <- c()
  # this assumes that the order of the labels
  # is in accordance to the order or issues
  # thus labels can be assigned to issues by order
  for (i in 1:length(issue_labels_list)) {
    issue_labels <- c(issue_labels, paste(issue_labels_list[[i]]$name, collapse = ", "))
  }
  # output data frame
  issues_csv <- cbind(issues_relevant, issue_labels)

  message(paste0("Writing data to: ", outfile))
  write.csv(x = issues_csv, file = outfile, quote = TRUE, row.names = FALSE)
}
