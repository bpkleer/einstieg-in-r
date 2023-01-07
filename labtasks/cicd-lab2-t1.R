###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 1                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries and loading students' solution
library("testthat")
local_edition(3)

# pilot solution
pss <- readRDS(
  "./data/pss.rds"
)

# Beobachtungen und Variablen aus Envorinment ablesen
dim(pss)

# Ansprechen erste Zahl des Vektors
solvarCases <- dim(pss)[1]

solvarCount <- dim(pss)[2]

# loading source
source(
  "./solution.R",
  chdir = TRUE
)

# test
test_that(
  "correct task 1", 
  {
    expect_equal(
      solvarCases, 
      varCases
    )
    
    expect_equal(
      solvarCount, 
      varCount
    )
  }
)
