###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 2 c)                                           #
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
soltpMean <- mean(
  pss$trstplt, 
  na.rm = TRUE
)

soltpMed <- median(
  pss$trstplt, 
  na.rm = TRUE
)

# loading source 
source(
  "./solution.R",
  chdir = TRUE
)

# test
test_that(
  "correct task 2c", 
  {
    expect_equal(
      soltpMean, 
      tpMean
    )
    
    expect_equal(
      soltpMed, 
      tpMed
    )
  }
)
