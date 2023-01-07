###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 4                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries and loading students' solution
pss <- readRDS(
  "./data/pss.rds"
)

# loading source
source(
  "./solution.R",
  chdir = TRUE
)

# pilot solution
solwkDist <- pss %>% 
  group_by(district) %>% 
  summarize(
    mean(wkhtot)
  )

# preparation to inherit different colnames or extra argument na.rm=TRUE
solVec <- as.numeric(
  c(
    solwkDist[1, 2],
    solwkDist[2, 2], 
    solwkDist[3, 2], 
    solwkDist[4,2], 
    solwkDist[5, 2]
  )
)

Vec <- as.numeric(
  c(
    wkDist[1, 2],
    wkDist[2, 2], 
    wkDist[3, 2], 
    wkDist[4,2], 
    wkDist[5, 2]
  )
)

# test 
library("testthat")
local_edition(3)

test_that(
  "correct task 4", 
  {
    expect_equal(
      solVec, 
      Vec
    )
    
  }
)
