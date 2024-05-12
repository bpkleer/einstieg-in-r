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

leon <- list(
  id = 243,
  username = "g32013",
  name = "Leon Klemm",
  state = NA,
  locked = NA,
  avatar_url = "https://gitlab.ub.uni-giessen.de/uploads/-/system/user/avatar/243/avatar.png",
  web_url = "https://gitlab.ub.uni-giessen.de/g32013",
  access_level = NA,
  created_at = NA,
  expires_at = NA
)

meike <- list(
  id = 149,
  username = "J_E8E7E5F",
  name = "Meike Schulz-Narres",
  state = NA,
  locked = NA,
  avatar_url = "https://gitlab.ub.uni-giessen.de/uploads/-/system/user/avatar/149/avatar.png",
  web_url = "https://gitlab.ub.uni-giessen.de/J_E8E7E5F",
  access_level = NA,
  created_at = NA,
  expires_at = NA
)

dfGroup <- rbind(
  dfGroup,
  leon,
  meike
)

dfGroup$commits <- 0

dfGroup

# transfer old commits
dfGroup$commits[dfGroup$username == "bpkleer"] <- dfGroup$commits[dfGroup$username == "bpkleer"] + 92
dfGroup$commits[dfGroup$username == "g32013"] <- dfGroup$commits[dfGroup$username == "g32013"] + 27
dfGroup$commits[dfGroup$username == "J_E8E7E5F"] <- dfGroup$commits[dfGroup$username == "J_E8E7E5F"] + 71

dfGroup <- dfGroup[,c("name", "username", "commits", "web_url", "avatar_url")]

# adding new commits
# get commits per new repository
newrepo <- GET(
  paste0(
    "https://gitlab.ub.uni-giessen.de/api/v4/projects/704/repository/contributors?private_token=",
    token
  )
)

newrepo <-  fromJSON(rawToChar(newrepo$content))

for (i in 1:dim(dfGroup)[1]) {
  for (j in 1:dim(newrepo)[1]) {
    if (dfGroup$name[i] == newrepo$name[j]) {
      dfGroup$commits[i] <- dfGroup$commits[i] + newrepo$commits[j]
    }
  }
}

dfGroupjson <- toJSON(
  dfGroup, 
  pretty = TRUE
)

# save file into data-folder
write(
  dfGroupjson, 
  "./data/statsplus.json"
)
