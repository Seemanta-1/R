# Install packages if not installed
install.packages("rvest")
install.packages("dplyr")
install.packages("stringr")
install.packages("progress")

library(rvest)
library(dplyr)
library(stringr)
library(progress)

# Homepage URL
url <- "https://en.prothomalo.com/"

# Read homepage HTML
page <- read_html(url)

# Extract all <a> tags
links <- page %>%
  html_nodes("a") %>%
  html_attr("href")

# Filter only article links (skip category pages)
news_links <- links[grepl("^https://en.prothomalo.com/.+/.+/", links)]
news_links <- unique(news_links)

cat("Total article links found:", length(news_links), "\n")

# Progress bar setup
pb <- progress_bar$new(total = length(news_links), format = "Scraping [:bar] :current/:total (:percent)")

# Function to scrape one article
scrape_article <- function(link) {
  pb$tick()
  tryCatch({
    article_page <- read_html(link)
    
    # Extract title
    title <- article_page %>%
      html_node("h1") %>%
      html_text(trim = TRUE)
    
    # Extract publish date
    date <- article_page %>%
      html_nodes("time") %>%
      html_attr("datetime") %>%
      .[1]
    
    # Extract article text (class-based)
    text_nodes <- article_page %>%
      html_nodes(".article-body p, .story-content p") %>%
      html_text(trim = TRUE)
    
    text <- paste(text_nodes, collapse = " ")
    
    data.frame(
      link = link,
      title = ifelse(is.null(title), NA, title),
      text = ifelse(length(text) == 0, NA, text),
      date = ifelse(is.null(date), NA, date),
      stringsAsFactors = FALSE
    )
  }, error = function(e) {
    data.frame(link = link, title = NA, text = NA, date = NA, stringsAsFactors = FALSE)
  })
}

# Loop through all links and scrape
results <- lapply(news_links, scrape_article)

# Bind into one dataframe
news_data <- bind_rows(results)

# Show first few rows
print(head(news_data, 5))
cat("\nTotal Articles Scraped:", nrow(news_data), "\n")

# Optionally save to CSV
write.csv(news_data, "prothomalo_articles.csv", row.names = FALSE)
cat("CSV file 'prothomalo_articles.csv' has been created successfully.\n")
