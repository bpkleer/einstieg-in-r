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
  "psych",
  "car"
  )
)



# female ist erste Gruppe, daher less! Denn Frauen-Mann soll ja negativ sein!
solmt1 <- t.test(
  pss$trstprl ~ pss$gndr,     
  mu = 0,                        
  alternative = "less",     
  paired = FALSE,    # ungepaarte Stichproben!            
  var.equal = FALSE  # Option des Levene-Tests!
)   

# loading source 
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
      solmt1, 
      mt1
    )
  }
)

