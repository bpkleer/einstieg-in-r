# An optional custom script to run before Hugo builds your site.
# You can delete it if you do not need it.

# Skript zum Download Gitlab-Commits (Kenntlichmachung der Arbeit)
# Für Github siehe template in ghcontributors in hugo-learner-theme
# Autor: B. Philipp Kleer

# Libraries ----
library(httr)
library(jsonlite)
library(tidyverse)

# your private token (read_api only) ----
token <- ""

# Making old transfer ----
leon <- list(
  name = "Leon Klemm",
  email = "leon.p.klemm@sowi.uni-giessen.de",
  commits = 27,
  avatar_url = "https://gitlab.ub.uni-giessen.de/uploads/-/system/user/avatar/243/avatar.png",
  web_url = "https://gitlab.ub.uni-giessen.de/g32013"
)

meike <- list(
  name = "Meike Schulz-Narres",
  email = "meike.schulz-narres@sowi.uni-giessen.de",
  commits = 71,
  avatar_url = "https://gitlab.ub.uni-giessen.de/uploads/-/system/user/avatar/149/avatar.png",
  web_url = "https://gitlab.ub.uni-giessen.de/J_E8E7E5F"
)

dfGroup <- as.data.frame(
  rbind(leon, meike)
)

# adding new commits
# get commits per new repository
newrepo <- GET(
  paste0(
    "https://gitlab.com/api/v4/projects/57776061/repository/contributors?private_token=",
    token
  )
)

newrepo <-  fromJSON(rawToChar(newrepo$content))

# filter double entries from different sources
newrepo <- newrepo |> 
  select(name, email, commits) |> 
  mutate(
    avatar_url = NA, 
    web_url = NA
  ) |> 
  filter(email != "philipp.kleer@sowi.uni-giessen.de" & email != "philipp.kleer@posteo.comr")

# Old transfer
newrepo$commits[newrepo$name == "Philipp Kleer"] <- newrepo$commits[newrepo$name == "Philipp Kleer"] + 93
newrepo$web_url[newrepo$name == "Philipp Kleer"] <- "https://gitlab.com/bpkleer"

for (i in 1:dim(newrepo)[1]) {
  if (is.na(newrepo$avatar_url[i])) {
    avatarUrl <- 
      fromJSON(
        rawToChar(
          GET(
            paste0(
              "https://gitlab.com/api/v4/avatar?email=",
              newrepo$email[i]
            )
          )$content
        )
      )
    
    newrepo$avatar_url[i] <- avatarUrl$avatar_url
  }
}

dfGroup <- as.data.frame(rbind(dfGroup, newrepo))

rownames(dfGroup) <- NULL
dfGroup$commits <- as.numeric(dfGroup$commits)

dfGroup <- dfGroup |> 
  arrange(desc(commits))

dfGroupjson <- toJSON(
  dfGroup, 
  pretty = TRUE,
  auto_unbox = TRUE
)

# save file into data-folder
write(
  dfGroupjson, 
  "./data/statsplus.json"
)
