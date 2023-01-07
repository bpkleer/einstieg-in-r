###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Lab tasks zu Lernblock 2                                                #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

#  1. Lade den Datensatz pss in das environment. 
pss <- readRDS(
  url("https://bpkleer.de/public/pss.rds"),
  "rb"
)

# 2. Berechne folgende lineare Regressionsmodelle auf die Variable Vertrauen 
#    in Politiker:innen (trstplt):
#    a) Zufriedenheit mit der Demokratie (stfdem) (model1)
#    b) plus Zufriedenheit mit Wirtschaft (stfeco) (model2)
#    c) plus Vertrauen in Parteien (trstprt) (model3)
#    d) plus Kontrollvariablen: Gender (gndr), Schulabschluss (edu), Alter (agea)
#       und Einkommen (income) (model4) 
#       [Referenzkategorien: weiblich, Master, 10. Dezil]

# a)
model1 <- lm(
  trstplt ~ 1 + stfdem,
  pss
)

summary(model1)

# b)
model2 <- lm(
  trstplt ~ 1 + stfdem + trstprl,
  pss
)

summary(model2)

# c)
model3 <- lm(
  trstplt ~ 1 + stfdem + trstprl + trstprt,
  pss
)

summary(model3)

# d)
levels(pss$gndr)
pss$gndr <- relevel(
  pss$gndr, 
  "female"
)

levels(pss$edu)
pss$edu <- relevel(
  pss$edu, 
  "ES-ISCED V"
)

levels(pss$income)
pss$income <- relevel(
  pss$income, 
  "10th decile"
)


model4 <- lm(
  trstplt ~ 1 + stfdem + trstprl + trstprt + gndr + edu + agea + income,
  pss
)

summary(model4)

# 3. Nun extrahiere aus den Modellen Werte und speichere diese jeweils in einem Objekt:
#    a) erklärte Varianz in model2 in rsquaredmod2
#    b) erklärte Varianz in model4 in rsquaredmod4
#    c) Name alle signifikanten Variablen Model3 in Charakter-Vektor sigvars

# a)
rsquredmod2 <- summary(model2)$adj.r.squared

# b)
rsquredmod4 <- summary(model4)$adj.r.squared

# c)
summary(model3)
sigvars <- c(
  "trstprl", 
  "trstprt"
)

# 4. Gib einen einfachen Koeffizienten-Plot aus, in dem die Modelle 1, 2 und
#    3 angezeigt werden, und speichere diesen Plot in olsplot.
library("dotwhisker")
olsplot <- dwplot(
  list(
    model1, 
    model2, 
    model3
  )
)

olsplot

# 5. Speichere eine einfache exportfähig Tabelle, in der alle Modelle 
#    aufgelistet sind im Objekt olstab.
library("modelsummary")
olstab <- modelsummary(
  list(
    model1, 
    model2, 
    model3, 
    model4
  )
)

olstab
