###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 1 task 3 b)                                           #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# preparations
sol1c <- 18 / 6 * 3^2

sol2c <- c(
  1.73, 
  1.84,
  1.61,
  2.02,
  1.97
)

# pilot solution
solsol3b <- sol1c * sol2c

# loading students' solutions 
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
      solsol3b, 
      sol3b
    )
  }
)
