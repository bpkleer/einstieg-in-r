###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Lab tasks zu Lernblock 1                                                #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Meike Schulz-Narres, B. Philipp Kleer                          #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

#  1. Führe folgende Rechnungen in R aus und speichere die Ergebnisse in
#     Objekten. Der Objektname steht jeweils in Klammern!
#     (a) 6 ∗ 8 − 2 (SOL1A)
#     (b) 7 + 9 ∗ 4 (sol1b)
#     (c) 18/6 ∗ 3^2 (sol1c)

# a
sol1a <-  6 * 8 - 2

# b
sol1b <- 7 + 9 * 4

# c
sol1c <- 18 / 6 * 3^2

# 2. Erstelle Vektoren mit folgendem Inhalt. Benenne die neuen Vektoren wie 
#    in den Klammern angezeigt!
#    (a) Kairo, Las Vegas, Colombo, Johannesburg, München (sol2a)
#    (b) 37, 22, 29, 46, 51 (sol2b)
#    (c)  (sol2c)

# a
sol2a <-  c(
  "Kairo",
  "Las Vegas",
  "Colombo", 
  "Johannesburg", 
  "München"
)

# b
sol2b <- c(
  37, 
  22,
  29,
  46,
  51
)

# c
sol2c <- c(
  1.73, 
  1.84,
  1.61,
  2.02,
  1.97
)

# 3. Du hast schon die Rechnungen mit einfachen Zahlen kennengelernt. 
#    Das Gleiche kannst du auch mit Objekten machen.
#    (a) Subtrahiere sol1a von sol1b. Speichere das Ergebnis in sol3a.
#    (b) Multipliziere sol1c mit dem Vektor sol2c. Speichere das Ergebnis in sol3b.
#    (c) Dividiere sol2b durch sol1b und multipliziere es mit sol2c. Speichere das Ergebnis in sol3c.

# a
sol3a <- sol1b - sol1a

# b
sol3b <- sol1c * sol2c

# c
sol3c <-  sol2b / sol1b * sol2c