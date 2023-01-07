###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 1 task 3 a)                                           #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# preparations
sol1a <-  6 * 8 - 2
sol1b <- 7 + 9 * 4

# pilot solution
solsol3a <- sol1b - sol1a

# loading students' solutions 
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
      solsol3a, 
      sol3a
    )
  }
)
