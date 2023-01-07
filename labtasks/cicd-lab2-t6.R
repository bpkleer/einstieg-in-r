###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# CI/CD Control Lab 2 task 6                                              #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Libraries and loading students' solution
solpss <- readRDS(
  "./data/pss.rds"
)

# pilot solution
solpss$solageaRec <- c()

for (i in 1:length(solpss$agea)) {   #Schleife über die Länge des Vektors, auch manuell möglich (5000)
  if (solpss$agea[i] >= 25 | is.na(solpss$agea[i])) {
    solpss$solageaRec[i] <- 0
  } else if (solpss$agea[i] < 25) {
    solpss$solageaRec[i] <- 1
  }
}

# loading source
source(
  "./solution.R",
  chdir = TRUE
)

# Kontrolle
table(
  pss$agea,
  solpss$solageaRec
)

# test
library("testthat")
local_edition(3)

test_that(
  "correct task 6", 
  {
    expect_equal(
      solpss$solageaRec, 
      pss$ageaRec
    )
  }
)
