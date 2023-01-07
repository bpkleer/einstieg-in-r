# An optional custom script to run before Hugo builds your site.
# You can delete it if you do not need it.

# Skript zum Download Gitlab-Commits (Kenntlichmachung der Arbeit)
# Für Github siehe template in ghcontributors in hugo-learner-theme
# Autor: B. Philipp Kleer

# Libraries ----
library("httr")
library("jsonlite")

# your private token (read_api only) ----
token <- ""

# get group members ----
group <-  GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/groups/293/members?private_token=",
    token
  )
)

dfGroup <-  fromJSON(rawToChar(group$content))
dfGroup

# get commits per repository
lb4 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/317/repository/contributors?private_token=",
    token
  )
)

lb4 <-  fromJSON(rawToChar(lb4$content))

# deleted wrong bpkleer
delrow <- c()
count <- 0
for (i in 1:dim(lb4)[1]) {
  if (lb4$name[i] == "bpkleer") {
    count <- count + lb4$commits[i]
    delrow <- c(delrow, i)
  }
}
lb4 <- lb4[-c(delrow), ]

i <- 1

repeat {
  if (lb4$name[i] != "B. Philipp Kleer") {
    i <-  i + 1
  }
  else if (lb4$name[i] == "B. Philipp Kleer") {
    lb4$commits[i] <- lb4$commits[i] + count
    break
  }
}

# Back to main df, creating commits var and counting over repositories

# Meikes oder Leons Namen ändern
for (i in 1:dim(lb4)[1]) {
  if (lb4$name[i] == "Meike") {
    lb4$name[i] <-  "Meike Schulz-Narres"
  }
  if (lb4$name[i] == "g32013") {
    lb4$name[i] <-  "Leon Klemm"
  }
}

dfGroup$commits <- 0

dfGroup
for (i in 1:dim(dfGroup)[1]) {
  for (j in 1:dim(lb4)[1]) {
    if (dfGroup$name[i] == lb4$name[j]) {
      dfGroup$commits[i] <- dfGroup$commits[i] + lb4$commits[j]
    }
  }
}

dfGroup <- dfGroup[,c("name", "username", "commits", "web_url", "avatar_url")]

dfGroupjson <- toJSON(
  dfGroup, 
  pretty = TRUE
)

# save file into data-folder
write(
  dfGroupjson, 
  "./data/statsplus.json"
)
