# script to download counts of commits in git-repository
# if you use github, you can just copy the ghcontributors.html and change the 
# url to yours
# in case you use gitlab, this script will give you commits per person
# Author: B. Philipp Kleer
# Project: Statistik+

# Libraries ----
library("httr")
library("jsonlite")

# your private token ----
token <- "" # your personal private token in gitlab

# get repository members ----
# in case you have several repositories in one group and want to count all
# commits in that group, you should access the group members per API here
members <-  GET(
  paste0(
  "https://gitlab.ub.uni-giessen.de/api/v4/projects/328/members?private_token=",
  token
  )
)

dfmembers <-  fromJSON(rawToChar(members$content))
dfmembers

# get commits in that repository
# if you have several repositories, you just repeat the step per repository and
# rbind all data in the end together
commits <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/328/repository/contributors?private_token=",
    token
    )
)

dfcommits <-  fromJSON(rawToChar(commits$content))

# Back to main df, creating commits var and counting over repositories
# this step is only necessary, if you are using a group
# furthermore, it restricts the count of commit to user of the group
# in case you let people from outside the group commit, too, this step would 
# exclude their count and their contribution count (not recommended)
dfmembers$commits <- 0

dfmembers


for (i in 1:dim(dfmembers)[1]) {
  for (j in 1:dim(dfcommits)[1]) {
    if (dfmembers$name[i] == dfcommits$name[j]) {
      dfmembers$commits[i] <- dfmembers$commits[i] + dfcommits$commits[j]
    }
  }
}

dfmembers <- dfmembers[,-c(1, 4, 7, 8, 9)]

dfmembersJSON <- toJSON(
  dfmembers, 
  pretty = TRUE
  )

# save file into data folder of hugo-learner-theme
write(
  dfmembersJSON, 
  "/your-path/data/glcommits.json"
)

