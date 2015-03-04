# linux_background
Sets your background to be a random image from a subreddit.
How it works:
  Have a file named 'subreddits' in the same folder as the script.
    This file will contain a list of subreddits (one on each line) to search
  A random subreddit is chosen and a random image from the top 25 is chosen and set to be the background
  Alternatively, a specific subreddit can be passed into the script
Possible uses:
  Have the script run at set intervals to always change your background.
  
Limitations:
  Only works on subreddits with image posts (will error if a text-only subreddit is chosen)
  Only sets backgrounds for xfce
