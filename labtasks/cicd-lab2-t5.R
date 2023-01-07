###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 5                                              #
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

# Loading source
source(
  "./solution.R",
  chdir = TRUE
)

pss$ageaRec <- NULL

# pilot solution
soldfLiLe <- pss %>% 
  dplyr::filter(
    edu == "ES-ISCED I" & (income == "1st decile" | income == "2nd decile" | income == "3rd decile") 
  )


# test
library("testthat")
local_edition(3)

test_that(
  "correct task 5", 
  {
    expect_equal(
      soldfLiLe, 
      dfLiLe
    )
  }
)
