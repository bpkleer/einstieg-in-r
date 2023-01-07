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

solmodel2 <- lm(
  trstplt ~ 1 + stfdem + trstprl,
  pss
)

install.packages(
  c(
    "modelsummary",
    "dotwhisker"
  )
)

# pilot solution
solrsquaredmod2 <- summary(solmodel2)$adj.r.squared

# loading students' solution
source(
  "./solution.R",
  chdir = TRUE
)
# test
library("testthat")
local_edition(3)

test_that(
  "correct task 3a", 
  {
    expect_equal(
      rsquaredmod2, 
      solrsquaredmod2
    )
  }
)
