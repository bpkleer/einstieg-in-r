###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 1 task 1 c)                                           #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# pilot solution
solsol1c <- 18 / 6 * 3^2

# loading students' solutions 
source(
  "./solution.R",
  chdir = TRUE
)

# test
library("testthat")
local_edition(3)

test_that(
  "correct task 1c", 
  {
    expect_equal(
      solsol1c, 
      sol1c
    )
  }
)
