###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Skript zur Einheit 7                                                    #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:  M. Schulz-Narres, B. Philipp Kleer                              #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        #
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Tabellen ----
pss <- readRDS("./data/pss.rds")
pss

table1 <- table(pss$stfdem)
table1

# gültige Fälle aus der Tabelle
sum1 <- sum(
  table(
    pss$stfdem
  )
) 

sum1

# Summe der NA's
sum2 <- sum(
  is.na(
    pss$stfdem
  )
)
sum2

# Gesamtlänge: Gültige Fälle + NA's
length1 <- length(pss$stfdem)
length1

table2 <- table(
  pss$stfdem,
  useNA = "ifany"
)
table2

# install.packages("summarytools")
library("summarytools")

freq1 <- freq(pss$stfdem)
freq1

table3 <- table(
  pss$stfdem, 
  pss$gndr
)

table3 

mytable <- table(
  pss$stfdem, 
  pss$gndr
)
mytable

# Zeilenprozentuierung
prop1 <- prop.table(
  mytable, 
  1
) 
prop1

# alternativer Weg mit table()-Funktion
prop2 <- prop.table(
  table(
    pss$stfdem, 
    pss$gndr
  ), 
  1
)
prop2

# Spaltenprozentuierung
prop3 <- prop.table(
  mytable,
  2
)
prop3

# Gesamtprozentuierung
prop4 <- prop.table(mytable)
prop4


# Zeilenrandhäufigkeiten
table4 <- margin.table(
  mytable, 
  1
)
table4

# Spaltenrandhäufigkeiten
table5 <- margin.table(
  mytable, 
  2
)
table5

# > Kreuztabellen ----
# if(!require("gmodels")) install.packages("gmodels")
library("gmodels")

ctab1 <- CrossTable(
  pss$stfdem, 
  pss$gndr
)
ctab1

mytable <- table(
  pss$stfdem, 
  pss$gndr
)
mytable

# Zusammmenhangsmaße ----
chi1 <- chisq.test(mytable)
chi1

chi2 <- chisq.test(
  pss$stfdem, 
  pss$gndr
)
chi2

str(chi1)

ls(chi1)

chi1$expected

library("DescTools")

cv1 <- CramerV(
  pss$stfdem,       
  pss$gndr,          
  conf.level = 0.95 # Konfidenzintervall
)  
cv1

# Korrelationen berechnen ----
plot(
  pss$trstprl, 
  pss$trstplt
)

plot(
  jitter(
    pss$trstprl, 
    3
  ) ~ 
    jitter(
      pss$trstplt, 
      3
    )
)

cor1 <- cor(
  pss$trstprl, 
  pss$trstplt, 
  method = "pearson",  # alternativ hier "spearman"  
  use = "complete.obs"
)    
cor1

# > Korrelationen graphisch darstellen ---- 
# install.packages("psych")
library("psych")

corr.test(
  pss$trstprl, 
  pss$trstplt,
  method = "pearson",      
  use = "complete.obs"
)

cor2 <- cor(
  pss[c(
    "trstprl", 
    "trstplt",
    "trstprt",
    "trstlgl"
  )
  ],
  method = "pearson",
  use = "complete.obs"
)  
cor2

cortest2 <- corr.test(
  pss[c(
    "trstprl",
    "trstplt",
    "trstprt",
    "trstlgl"
  )
  ],
  method = "pearson",
  use = "complete.obs"
)  
cortest2

pairs.panels(
  pss[c(
    "stfdem",
    "trstprl",
    "trstlgl",
    "stfeco"
  )
  ],
  method = "pearson",   
  jiggle = TRUE,   # für pseudometrische Daten
  stars = TRUE  # Konvention für Signifikanzen
)

# install.packages("corrplot")
library("corrplot")

cor3 <- corr.test(
  pss[c(
    "trstprl",
    "trstplt",
    "trstprt",
    "trstlgl"
  )
  ],
  method = "pearson",
  use = "complete.obs"
) 

cor3

ls(cor3)

corrplot(
  cor3$r, 
  p.mat = cor3$p,    # Matrix mit p-Werten
  insig = "blank",   # nicht signifikante = leer
  type = "upper",    # auch lower möglich
  method = "circle" # verschiedene Optionen möglich
)    

# Mittelwertvergleiche ----
# > Ein-Stichproben t-Test ----
t.test(
  pss$agea, 
  mu = 36.8,
  alternative = "two.sided"
)  

diff_age <- mean(pss$agea, na.rm = TRUE) - 36.8
diff_age

# one-sided, greater
t.test(
  pss$agea, 
  mu = 36.8, 
  alternative = "greater"
)

# one-sided, lower
t.test(
  pss$agea,
  mu = 36.8, 
  alternative = "less"
)

# > Zwei-Stichproben t-Test (ungepaart) ----
library("car")
leveneTest(
  pss$wkhtot,      
  pss$gndr,        
  center = "mean"
) 

t.test(
  pss$wkhtot ~ pss$gndr,     
  mu = 0,                        
  alternative = "two.sided",     
  paired = FALSE,    # ungepaarte Stichproben!            
  var.equal = TRUE  # Option des Levene-Tests!
)   

leveneTest(
  pss$wkhtot,
  pss$edu,
  center = "mean"
)

t.test(
  pss$wkhtot[pss$edu == "ES-ISCED I"],
  pss$wkhtot[pss$edu == "ES-ISCED V"], 
  mu = 0, 
  alternative = "two.sided", 
  paired = FALSE, 
  var.equal = TRUE
)

t.test(
  pss$trstprl,
  pss$trstprl, 
  alternative = "two.sided", 
  paired = TRUE
)

# > Zwischen mehr als zwei Gruppen  ----
leveneTest(
  pss$wkhtot ~ pss$edu,
  center = "mean"
)

oneway.test(
  pss$wkhtot ~ pss$edu,
  var.equal = TRUE
)

pairwise.t.test(
  pss$wkhtot, # metrische Variable zuerst
  pss$edu, # Gruppenvariable als zweites
  p.adj = "holm"  # Korrektur (Standardverwendung)
) 


