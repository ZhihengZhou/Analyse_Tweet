
merge_string_list <- function(string_list, sep){
  
  if(length(string_list) <= 1){
    return(string_list)
  }
  
  merged_string = string_list[1]
  for(i in 2:length(string_list)){
    merged_string = paste(merged_string, string_list[i], sep = sep)
  }
  return(merged_string)
}

save_df <- function(rt, save_name){
  
  newrt = data.frame(rt['user_id'])
  for(col_name in colnames(rt)){
    
    if(typeof(rt[[col_name]]) == "list"){
      column <- sapply(rt[[col_name]], function(x){
        return(merge_string_list(x, " "))
      })
      newrt[,col_name] = column
    }
    else{
      newrt[,col_name] = rt[,col_name]
    }
    
  }
  write.csv(newrt, file = save_name, row.names = F)
}


auto_search_tweets <- function(query, search_amount_once, search_interval, total_duration){
  
  # Get script start time.
  start_time = Sys.time()
  rt = search_tweets(
    query, n = search_amount_once, include_rts = FALSE
  )
  
  # Select tweet created during the show.
  inDuration = which(rt$created_at >= start_time)
  tweet_df = rt[inDuration,]
  previous_tweets_amount = nrow(tweet_df)
  
  Sys.sleep(search_interval)
  
  while (TRUE) {
    
    # Search tweets
    rt = search_tweets(
      query, n = search_amount_once, include_rts = FALSE
    )
    inDuration = which(rt$created_at >= start_time)
    rt = rt[inDuration,]
    
    # Combine tweet data frame
    tweet_df = rbind(tweet_df, rt)
    raw_rows = nrow(tweet_df)
    tweet_df = unique(tweet_df)
    unique_rows = nrow(tweet_df)
    
    # No new tweets found, increase the search interval.
    if(unique_rows - previous_tweets_amount <= 0){
      search_interval = search_interval * 2
    }
    
    # Searched tweets are all new, decrease the search interval.
    if(unique_rows - previous_tweets_amount >= search_amount_once){
      search_interval = search_interval / 2
    }
    previous_tweets_amount = unique_rows
    print(previous_tweets_amount)
    print(search_interval)
    
    now_time = Sys.time()
    if(now_time - start_time > total_duration){
      
      # Save csv
      file_name = paste(query, Sys.Date(), total_duration, sep = "_")
      file_name = paste("../Data/", file_name, ".csv", sep = "")
      save_df(tweet_df, file_name)
      
      break
    }
    
    Sys.sleep(search_interval)
  }
  
}
