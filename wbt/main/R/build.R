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
lb1 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/314/repository/contributors?private_token=",
    token
  )
)

lb1 <-  fromJSON(rawToChar(lb1$content))


lb2 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/315/repository/contributors?private_token=",
    token
  )
)

lb2 <-  fromJSON(rawToChar(lb2$content))

lb3 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/316/repository/contributors?private_token=",
    token
  )
)
lb3 <-  fromJSON(rawToChar(lb3$content))

lb4 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/317/repository/contributors?private_token=",
    token
  )
)
lb4 <-  fromJSON(rawToChar(lb4$content))

lb5 <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/318/repository/contributors?private_token=",
    token
  )
)

lb5 <-  fromJSON(rawToChar(lb5$content))

# bind all commits together
dfProject <- rbind(
  lb1, 
  lb2, 
  lb3, 
  lb4, 
  lb5
)

# deleted wrong bpkleer
delrow <- c()
count <- 0
for (i in 1:dim(dfProject)[1]) {
  if (dfProject$name[i] == "bpkleer") {
    count <- count + dfProject$commits[i]
    delrow <- c(delrow, i)
  }
}
dfProject <- dfProject[-c(delrow), ]

i <- 1

repeat {
  if (dfProject$name[i] != "B. Philipp Kleer") {
    i <-  i + 1
  }
  else if (dfProject$name[i] == "B. Philipp Kleer") {
    dfProject$commits[i] <- dfProject$commits[i] + count
    break
  }
}

# adding usernames (if commit messages have wrong names)
for (i in 1:dim(dfProject)[1]) {
  if (dfProject$name[i] == "Meike") {
    dfProject$name[i] <-  "Meike Schulz-Narres"
  }
  if (dfProject$name[i] == "g32013") {
    dfProject$name[i] <-  "Leon Klemm"
  }
}

# Back to main df, creating commits var and counting over repositories
dfGroup$commits <- 0

dfGroup
for (i in 1:dim(dfGroup)[1]) {
  for (j in 1:dim(dfProject)[1]) {
    if (dfGroup$name[i] == dfProject$name[j]) {
      dfGroup$commits[i] <- dfGroup$commits[i] + dfProject$commits[j]
    }
  }
}

# adding Leon's commits from old account
dfGroup$commits[3] <- dfGroup$commits[3] + 20

dfGroup <- dfGroup[,-c(1, 4, 7, 8, 9)]

dfGroupjson <- toJSON(
  dfGroup, 
  pretty = TRUE
)

# save file into data-folder
write(
  dfGroupjson, 
  "./data/statsplus.json"
)
