# load needed packages

library(xml2)
library(rvest)
library(lexRankr)
library(tidyverse)
library(dplyr)
library(tm)
library(stringr)
library(lubridate)

# First attempt at scraping stats table------------

# url to scrape

Stats_url <- "https://www.pro-football-reference.com/years/2017/passing.htm"

# read page html

page <- xml2::read_html(Stats_url)

# extract text from page html using selector

page_text <- rvest::html_text(rvest::html_nodes(page, "tbody td"))

column_names <- rvest::html_text(rvest::html_nodes(page, "thead th"))

QB_stats <- NULL

colnames(QB_stats) <- column_names

QB_stats <- page_text

View(QB_stats)


# Scraping stats table successfully using html_table-----------

url <- "https://www.pro-football-reference.com/years/2017/passing.htm"
football_stats <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="passing"]') %>%
  html_table()

football_stats_df <- data.frame(football_stats)

colnames(football_stats_df)[2] <- "Name"

football_stats_df$Name <- gsub("[[:punct:]]", "", football_stats_df$Name, fixed = F)

football_stats_df$Y.A <- as.numeric(football_stats_df$Y.A)

football_stats_df$Y.C <- as.numeric(football_stats_df$Y.C)

football_stats_df %>% 
  filter(Name %in% c("Alex Smith", "Kirk Cousins", "Tom Brady", "Drew Brees", "Russell Wilson", "Matt Ryan", "Philip Rivers", "Ben Roethlisberger")) %>% 
  ggplot(aes(x = Y.A, y = Y.C)) + 
  geom_text(aes(label = Name)) +
  labs(x = "Yards Per Pass Attempt", y = "Yards Per Pass Completion", title = "2017 Regular Season Comparison: Alex Smith vs Kirk Cousins", subtitle = "Alex Smith Outperformed Kirk Cousins in 2017", caption = "Source: pro-football-reference.com")

