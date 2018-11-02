

The size of each show's csv:
Question Time   : 40.1M	 44017 rows
Andrew Marr     : 27.7M	 27551 rows
The Aganda(UK)  : 1.5k 	 0 rows (No collected data)
Q&A             : 42.7M	 51070 rows
Insiders        : 24.5M	 24862 rows
The project     : 10.5M	 10014 rows
Meet The Press  : 68.4kB 52 rows
Fox and Friends : 36.2M	 20202 rows
PBS News Hour   : 1.8M	 1577 rows
Morning Joe     : 116.3M 102408 rows


To read the csv in R (Example):

library(rtweet)
df = read_twitter_csv(csv_file_name)
