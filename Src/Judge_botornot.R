
library(tweetbotornot)

get_bot_score <- function(rt){
  
  rt$bot_score = NA
  
  bot = botornot(rt$user_id)
  
  for(i in 1:nrow(bot)){
    
    sel = which(rt$user_id == bot$user_id[i])
    rt$bot_score[sel] = bot$prob_bot[i]
  }
  
  return(rt)
  
}
