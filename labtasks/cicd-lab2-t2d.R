###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 2 d)                                           #
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
soltpVar <- var(
  pss$trstplt,
  na.rm = TRUE
)

soltpSd <- sd(
  pss$trstplt,
  na.rm = TRUE
)

# Besschreibung: In der Spannweite von 0 bis 10 liegt das durchschnittliche
# Vertrauen in Politiker in Panem bei 4,73. Die durchschnittliche Abweichung
# von Mittelwert beträgt 1,88 und die durchschnittliche 
# quadrierte Abweichung 3,54.
# 50% der Bevölkerung vertrauen den Politkern zu weniger als 50%. 
# Das Vertrauen der mittleren 50% liegt zwischen 3 und 6.

# loading source 
source(
  "./solution.R",
  chdir = TRUE
)

# test 
test_that(
  "correct task 2d", 
  {
    expect_equal(
      soltpVar, 
      tpVar
    )
    
    expect_equal(
      soltpSd, 
      tpSd
    )
  }
)
