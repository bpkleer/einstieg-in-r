###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 1                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries 
library("dotwhisker")

# preparations
pss <- readRDS(
  "./data/pss.rds" 
)

solmodel1 <- lm(
  trstplt ~ 1 + stfdem,
  pss
)

solmodel2 <- lm(
  trstplt ~ 1 + stfdem + trstprl,
  pss
)

solmodel3 <- lm(
  trstplt ~ 1 + stfdem + trstprl + trstprt,
  pss
)

install.packages(
  c(
    "modelsummary",
    "dotwhisker"
  )
)

# pilot solution
sololsplot <- dwplot(
  list(
    solmodel1, 
    solmodel2, 
    solmodel3
  )
)

# loading students' solutions
source(
  "./solution.R",
  chdir = TRUE
)
# test
library("testthat")
local_edition(3)

test_that(
  "correct task 4", 
  {
    expect_equal(
      olsplot, 
      sololsplot
    )
  }
)
