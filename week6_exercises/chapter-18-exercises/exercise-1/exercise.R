# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!

source("apikey.R") # go to that that file, select all, and hit ctrl-enter

# Create a variable `movie_name` that is the name of a movie of your choice.

movie_name <- "Avengers"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!

base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
uri <- paste0(base_uri, resource)

query_params <- list("api-key" = nyt_key, "movie_name" = movie_name)
# What else do I need in order to get the access

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON

response <- GET(uri, query = query_params)
orbody <- content(response, "text")
data <- fromJSON(orbody)

# What kind of data structure did this produce? A data frame? A list?
is.data.frame(data)
is.list(data)

#It is a list

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
result <- data$results
# Flatten the movie reviews content into a data structure called `reviews`

reviews <- flatten(result)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables

review_list <- select(reviews, headline, summary_short, link.url)

# Create a list of the three pieces of information from above. 
# Print out the list.
print(review_list)
