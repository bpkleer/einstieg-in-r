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

install.packages(
  c(
    "modelsummary",
    "dotwhisker"
  )
)

# pilot solution
levels(pss$gndr)
pss$gndr <- relevel(
  pss$gndr, 
  "female"
)

levels(pss$edu)
pss$edu <- relevel(
  pss$edu, 
  "ES-ISCED V"
)

levels(pss$income)
pss$income <- relevel(
  pss$income, 
  "10th decile"
)

solmodel4 <- lm(
  trstplt ~ 1 + stfdem + trstprl + trstprt + gndr + edu + agea + income,
  pss
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
  "correct task 2d", 
  {
    expect_equal(
      model4, 
      solmodel4
    )
  }
)
