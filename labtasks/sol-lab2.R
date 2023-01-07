###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Lab tasks zu Lernblock 2                                                #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

#  1. Lade den Datensatz pss in das environment. Wie viele Beobachtungen und ---- 
#     Variablen hat der Datensatz? Speichere die Anzahl der Variablen in das 
#     Objekt varCount und die Anzahl der Beobachtungen in das Objekt varCases.

pss <- readRDS(
  url("https://bpkleer.de/public/pss.rds"),
  "rb"
)

# Beobachtungen und Variablen aus Envorinment ablesen
dim(pss)

# Ansprechen erste Zahl des Vektors
varCases <- dim(pss)[1]

varCount <- dim(pss)[2]

# 2. Gib die deskriptive Statistik für die Variable Vertrauen in Politiker aus. ---- 
#    Speichere den Wert jeweils in einem Objekt! Der Objektname steht in
#    Klammern. Schaue dir vorher im Codebook an, welches Skalenniveau die
#    Variable hat und wie sie kodiert ist. Beschreibe innerhalb des Skripts
#    die deskriptiven Werte dieser Variable ?ber die Kommentarfunktion.

# > a) Minimumm & Maximum ----
tpMin <- min(
  pss$trstplt,
  na.rm = TRUE
)

tpMax <- max(
  pss$trstplt,
  na.rm = TRUE
)

# Alternative:
range(
  pss$trstplt,
  na.rm = TRUE
)


# > b) Quantile & IQR ----
tpQuant <- quantile(
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


tpIQR <- IQR(
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


# > c) arithmetisches Mittel & Median ----
tpMean <- mean(
  pss$trstplt, 
  na.rm = TRUE
)

tpMed <- median(
  pss$trstplt, 
  na.rm = TRUE
)

# > d) Varianz & Standardabweichung ----
tpVar <- var(
  pss$trstplt,
  na.rm = TRUE
)

tpSd <- sd(
  pss$trstplt,
  na.rm = TRUE
)

# Besschreibung: In der Spannweite von 0 bis 10 liegt das durchschnittliche
# Vertrauen in Politiker in Panem bei 4,73. Die durchschnittliche Abweichung
# von Mittelwert beträgt 1,88 und die durchschnittliche 
# quadrierte Abweichung 3,54.
# 50% der Bevölkerung vertrauen den Politkern zu weniger als 50%. 
# Das Vertrauen der mittleren 50% liegt zwischen 3 und 6.


# 3. Gib die Quintile für die Variable Vertrauen in die Justiz aus. ----
#    Speichere das Ergebnis im Objekt (tjQuint).

tjQuint <- quantile(
  pss$trstlgl, 
  probs = seq(
    0,
    1, 
    0.2
  ),    
  na.rm = TRUE
) 

#  4. Gib die durchschnittlichen Arbeitsstunden der Menschen pro Woche ----
#     je Distrikt an (wkDist).
library("tidyverse")

wkDist <- pss %>% 
  group_by(district) %>% 
  summarize(
    mean(wkhtot)
  )


# 5. Erstelle ein Subset, welches Personen mit niedrigem Einkommen ----
#    (1. - 3. Dezil) oder Bildungsabschluss (ES-ISCED I) umfasst. 
#    Speichere das Subset im Objekt dfLiLe.

dfLiLe <- pss %>% 
  filter(
    edu == "ES-ISCED I" & (income == "1st decile" | income == "2nd decile" | income == "3rd decile") 
  )


# Zusatzaufgabe Programmierexkurs (freiwillig) ----
# Nutze dein Wissen zu einer for-Schleife und If-Else-Bedingungen, um eine neue
# Variable zu schaffen, die anzeigt, ob eine Person unter 25 Jahre alt ist. Die
# neue Variable soll Teil des Datensatzes pss sein und den Namen ageaRec haben.

#Initialisieren von ageaRec
pss$ageaRec <- c()

for (i in 1:length(pss$agea)) {   #Schleife über die Länge des Vektors, auch manuell möglich (5000)
  if (pss$agea[i] >= 25 | is.na(pss$agea[i])) {
    pss$ageaRec[i] <- 0
  } else if (pss$agea[i] < 25) {
    pss$ageaRec[i] <- 1
  }
}

# Kontrolle
table(
  pss$agea,
  pss$ageaRec
)

