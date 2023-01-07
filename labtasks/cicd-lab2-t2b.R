###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 2 b)                                           #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries and loading students' solution
library("testthat")
local_edition(3)

pss <- readRDS(
  "./data/pss.rds"
)

# pilot solution
soltpQuart <- quantile(
  pss$trstplt,
  na.rm = TRUE
)

# Alternative mit sequence-Funktion:
quantile(
  pss$trstplt, 
  probs = seq(
    0,
    1, 
    0.25
  ),    
  na.rm = TRUE
) 


soltpIQR <- IQR(
  pss$trstplt,
  na.rm = TRUE
)

# Alternative:
diff(
  quantile(
    pss$trstplt, 
    probs = c(
      0.25,
      0.75
    ),  
    na.rm = TRUE
  )
) 

# loading source
source(
  "./solution.R",
  chdir = TRUE
)

# test
test_that(
  "correct task 2b", 
  {
    expect_equal(
      soltpQuart, 
      tpQuart
    )
    
    expect_equal(
      soltpIQR, 
      tpIQR
    )
  }
)
