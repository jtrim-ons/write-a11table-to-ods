# Based on https://co-analysis.github.io/a11ytables/articles/a11ytables.html

library(dplyr)
library(rjson)
library(whisker)

;kkjkcover_df <- tibble::tribble( 
  ~"subsection_title",  ~"subsection_content",
  "Description", "Aspects of automobile design and performance.",
  "Properties",  "Suppressed values are replaced with the value '[c]'.",
  "Contact",     "The mtcars Team, telephone 0123456789."
)

contents_df <- tibble::tribble(
  ~"Sheet name", ~"Sheet title",
  "Notes",       "Notes used in this workbook",
  "Table 1",     "Car Road Tests (demo)",
  "Table 2",     "Lots of random numbers"
)

notes_df <- tibble::tribble(
  ~"Note number", ~"Note text",
  "[note 1]",     "US gallons.",
  "[note 2]",     "Retained to enable comparisons with previous analyses."
)

stats_df <- mtcars %>%
  head() %>%
  tibble::rownames_to_column("car") %>%
  subset(select = c("car", "cyl", "mpg"))

names(stats_df) <- c(
  "Car",
  "Cylinder count",
  "Miles per gallon [note 1]"  # notes go in headers, not cells
)

stats_df$Notes <- c(  # add 'Notes' column
  rep("[note 2]", 2), 
  rep(NA_character_, 4)
)

stats_df[3, 2:3] <- "[c]"  # suppressed (confidential) data

big_random_df <- data.frame(A=rnorm(250000), B=rnorm(250000))

my_a11ytable <- 
  a11ytables::create_a11ytable(
    tab_titles = c(
      "Cover",
      "Contents",
      "Notes",
      "Table 1",
      "Random numbers"
    ),
    sheet_types = c(
      "cover",
      "contents",
      "notes",
      "tables",
      "tables"
    ),
    sheet_titles = c(
      "The 'mtcars' Demo Datset",
      "Table of contents",
      "Notes",
      "Table 1: Car Road Tests",
      "Table 2: Lots of random numbers"
    ),
    blank_cells = c(
      NA_character_,
      NA_character_,
      NA_character_, 
      "Blank cells indicate that there's no note in that row",
      NA_character_
    ),
    sources = c(
      NA_character_,
      NA_character_,
      NA_character_, 
      "Motor Trend (1974)",
      "Random number generator"
    ),
    tables = list(
      cover_df,
      contents_df,
      notes_df,
      stats_df,
      big_random_df
    )
  )
# Warning: These tab_titles have been cleaned automatically: Table 1 (now
# Table_1).

my_wb <- a11ytables::generate_workbook(my_a11ytable)

openxlsx::saveWorkbook(my_wb, "a11ytables-publication.xlsx")
