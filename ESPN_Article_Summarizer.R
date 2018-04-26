# load needed packages

library(xml2)
library(rvest)
library(lexRankr)

# url to scrape

ESPN_url <- "http://www.espn.com/mens-college-basketball/story/_/id/23311712/commission-college-basketball-shares-recommendations-ncaa"

# read page html

page <- xml2::read_html(ESPN_url)

# extract text from page html using selector

page_text <- rvest::html_text(rvest::html_nodes(page, ".article-body p"))

# perform lexrank for top 5 sentences

top_5 <- lexRankr::lexRank(page_text,
                          #only 1 article; repeat same docid for all of input vector
                          docId = rep(1, length(page_text)),
                          #return 5 sentences to mimick /u/autotldr's output
                          n = 5,
                          continuous = TRUE)

# reorder the top 5 sentences to be in order of appearance in article

order_of_appearance <- order(as.integer(gsub("_","",top_5$sentenceId)))

# extract sentences in order of appearance

ordered_top_5 <- top_5[order_of_appearance, "sentence"]

# extract article title

page_title <- rvest::html_text(rvest::html_nodes(page, ".article-header h1"))

# storing extractions in a data frame

article_summary <- data.frame(Title = page_title, Text = ordered_top_5)











# misc

kyrie_irving <- 
  read_html("https://projects.fivethirtyeight.com/carmelo/kyrie-irving/")

kyrie_irving %>% 
  html_nodes(".label.two div") %>% 
  html_text()


library(RSelenium)

rD <- rsDriver(port = 4444L,  browser = "chrome")

remDr <- rD[["client"]]
remDr$navigate("https://projects.fivethirtyeight.com/carmelo/kyrie-irving/")

elem <- remDr$findElement(using="css selector", value=".desc")
elemtxt <- elem$getElementAttribute("div")



library(RSelenium)

rD <- rsDriver(port = 4444L,  browser = "chrome")

remDr <- rD[["client"]]
remDr$navigate("https://projects.fivethirtyeight.com/carmelo/kyrie-irving/")

library(XML)

master <- c()
n <- 1 # number of pages to scrape.  80 pages in total.  I just scraped 5 pages for this example.
for(i in 1:n) 
  site <- paste0("https://projects.fivethirtyeight.com/carmelo/kyrie-irving/") # create URL for each page to scrape
  remDr$navigate(site) # navigates to webpage
  
  elem <- remDr$findElement(using="id", value="war-chart") # get big table in text string
  elem$highlightElement() # just for interactive use in browser.  not necessary.
  elemtxt <- elem$getElementAttribute("outerHTML")[[1]] # gets us the HTML
  elemxml <- htmlTreeParse(elemtxt, useInternalNodes=T) # parse string into HTML tree to allow for querying with XPath
  fundList <- unlist(xpathApply(elemxml, '//input[@market-value]', xmlGetAttr, 'market-value')) # parses out just the fund name and ticker using XPath
  master <- c(master, fundList) # append fund lists from each page together






library('XML')
master <- c()
n <- 5 # number of pages to scrape.  80 pages in total.  I just scraped 5 pages for this example.
for(i in 1:n) {
  site <- paste0("https://www.fidelity.com/fund-screener/evaluator.shtml#!&ntf=N&ft=BAL_all&msrV=advanced&sortBy=FUND_MST_MSTAR_CTGY_NM&pgNo=",i) # create URL for each page to scrape
  remDr$navigate(site) # navigates to webpage
  
  elem <- remDr$findElement(using="id", value="tbody") # get big table in text string
  elem$highlightElement() # just for interactive use in browser.  not necessary.
  elemtxt <- elem$getElementAttribute("outerHTML")[[1]] # gets us the HTML
  elemxml <- htmlTreeParse(elemtxt, useInternalNodes=T) # parse string into HTML tree to allow for querying with XPath
  fundList <- unlist(xpathApply(elemxml, '//input[@title]', xmlGetAttr, 'title')) # parses out just the fund name and ticker using XPath
  master <- c(master, fundList) # append fund lists from each page together
}


ESPN_url <- "https://projects.fivethirtyeight.com/carmelo/kyrie-irving/"

# read page html

page <- xml2::read_html(ESPN_url)

# extract text from page html using selector

page_text <- rvest::html_text(rvest::html_nodes(page, ".market-value div"))


View(ordered_top_5)

bind_lexrank(page_text)
