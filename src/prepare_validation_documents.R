# takes the output file from parse_issue_json_to_csv() and
# creates four markdown files
# 1. user requirements
# 2. functional specifications
# 3. tests
# 4. validation matrix

# dependency
library("stringr")

prepare_validation_documents <- function(infile) {

  tabular_issues <- read.csv(infile, colClasses = "character")
  tabular_issues$number <- paste0("ID: #", tabular_issues$number)
  tabular_issues$created_at <- paste0("Creation date: ", tabular_issues$created_at)
  tabular_issues$updated_at <- paste0("Change date: ", tabular_issues$updated_at)
  tabular_issues$html_url <- paste0("Weblink: ", tabular_issues$html_url)
  tabular_issues$issue_labels <- paste0("**", tabular_issues$issue_labels, "**")
  # reorder
  tabular_issues <- tabular_issues[c("issue_labels", "number", "title", "updated_at", "created_at", "html_url", "body" )]

  # create a long sting to output
  output_test <- ""
  output_func_spec <- ""
  output_usr_req <- ""
  output_val_mat <- "| User requirement | Functional specification | Test |\n|-|-|-|\n"
  for(i in 1:nrow(tabular_issues)) {
    curr_issue <- tabular_issues[i, ]
    if (curr_issue$issue_labels == "**Test**") {
      output_test <- paste0(output_test, paste(curr_issue, collapse = "  \n"), "\n\n---\n")
    } else if (curr_issue$issue_labels == "**User requirement**") {
      output_usr_req <- paste0(output_usr_req, paste(curr_issue, collapse = "  \n"), "\n\n---\n")
      # first get the func spec substring of the body and then extract the hastags from it
      func_spec_refs <- str_extract_all(str_extract(string = curr_issue$body,
                                                    pattern = "\nFunctional specification:.*\n"),
                                        pattern = "#\\d+")[[1]]
      test_refs <- str_extract_all(str_extract(string = curr_issue$body,
                                               pattern = "\nTest:.*\n"),
                                   pattern = "#\\d+")[[1]]
      output_val_mat <- paste0(output_val_mat, "| ", gsub(x = curr_issue$number, pattern = "ID:", replacement = "")
                               , " | ",
                               paste(func_spec_refs, collapse = " "), " | ",
                               paste(test_refs, collapse = " "), "|\n")
    } else if (grepl(pattern = "Functional specification", x = curr_issue$issue_labels)) {
      output_func_spec <- paste0(output_func_spec, paste(curr_issue, collapse = "  \n"), "\n\n---\n")
    }
  }

  sys_date <- gsub(Sys.time(), pattern = " ", replacement = "_")
  test_file <- paste0("tests_", sys_date, ".md")
  message(paste0("Writing data to: ", test_file))
  usr_req_file <- paste0("user_requirements_", sys_date, ".md")
  message(paste0("Writing data to: ", usr_req_file))
  func_spec_file <- paste0("functional_specifications_", sys_date, ".md")
  message(paste0("Writing data to: ", func_spec_file))
  val_mat_file <- paste0("validation_matrix_", sys_date, ".md")
  message(paste0("Writing data to: ", val_mat_file))
  message(paste0("In: ", getwd()))
  # write to files
  cat(output_test, file = test_file)
  cat(output_usr_req, file = usr_req_file)
  cat(output_func_spec, file = func_spec_file)
  cat(output_val_mat, file = val_mat_file)
}
