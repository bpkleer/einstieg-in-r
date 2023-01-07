###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 1                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# preparations
pss <- readRDS(
  "./data/pss.rds" 
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
summary(solmodel3)

solsigvars <- c(
  "trstprl", 
  "trstprt"
)

#  loading students' solution
source(
  "./solution.R",
  chdir = TRUE
)
# test
library("testthat")
local_edition(3)

test_that(
  "correct task 3b", 
  {
    expect_equal(
      sigvars, 
      solsigvars
    )
  }
)
