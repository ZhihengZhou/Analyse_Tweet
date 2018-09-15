library(rtweet)

#Create tweet API token
create_token(
  app = "my_twitter_research_app",
  consumer_key = "G3MQONk4InSpaEbLEEii83NeR",
  consumer_secret = "sjhQId8edr4nSkccyDiwJwogA6vqHoGDkqGSnTXNCnlQ8kpvkM",
  access_token = "875178186383835137-iVunpJKrBqGdP9o59zICU20wzU4mwyD",
  access_secret = "ypOqFVOYtuwbXQZ9875iKUAZ7ijtRATFPbnZ6GgnC7MhL")

# Loading function
source("./Auto_Search_Base.R")

# Set paremeters
query = "#marr"
search_amount_once = 1500
search_interval = 300
total_duration = as.difftime(90, units = "mins")

# Run search function
auto_search_tweets(query = query, 
                   search_amount_once = search_amount_once,
                   search_interval = search_interval,
                   total_duration = total_duration)