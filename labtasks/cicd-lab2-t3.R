###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 3                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries and loading students' solution
library("testthat")
local_edition(3)

pss <- readRDS(
  "./data/pss.rds"
)

# pilot solution
soltjQuint <- quantile(
  pss$trstlgl, 
  probs = seq(
    0,
    1, 
    0.2
  ),    
  na.rm = TRUE
) 

# loading source
source(
  "./solution.R",
  chdir = TRUE
)

# test
test_that(
  "correct task 3", 
  {
    expect_equal(
      soltjQuint, 
      tjQuint
    )
  }
)
