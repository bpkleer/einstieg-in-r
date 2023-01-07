# Meine Forschungsfrage: 
# Inwieweit lässt sich die Zufriedenheit mit der Demokratie (`stfdem`)
# durch wirtschaftliche und soziostrukturelle Merkmale erklären (z.B. `stfeco`,
# `hinctnta`, `edulvlb`, `gndr`)?

# 5 gewählte metrische Variablen
# stfeco, stfhlth, stfedu, stflife, agea
# 2 gewählte kategorielle Variablen
# education & hh-income

# libraries
library("tidyverse")
library("psych")
library("corrplot")
library("car")
library("rstatix")
library("parameters")

# Datensatz wieder laden
essIt <- readRDS("../data/essIt.rds")

# 1. Korrelation zwischen abh. Variable und 5 weiteren metrischen Variablen
# a) stfeco & stfdem ----
plot(
  jitter(
    essIt$stfdem, 
    3
  ) ~ 
    jitter(
      essIt$stfeco,
      3
    )
)

# b) stfhlth & stfdem
plot(
  jitter(
    essIt$stfdem, 
    3
  ) ~ 
    jitter(
      essIt$stfhlth,
      3
    )
)

# c) stfedu & stfdem
plot(
  jitter(
    essIt$stfdem, 
    3
  ) ~ 
    jitter(
      essIt$stfedu,
      3
    )
)

# d) stflife & stfdem
plot(
  jitter(
    essIt$stfdem, 
    3
  ) ~ 
    jitter(
      essIt$stflife,
      3
    )
)

# e) agea & stfdem
plot(
  jitter(
    essIt$stfdem, 
    3
  ) ~ 
    jitter(
      essIt$agea,
      3
    )
)

# correlation berechnen
cor <- corr.test(
  essIt[, c("stfdem", "stfeco", "stfhlth", "stfedu", "stflife", "agea")],
  method = "pearson", 
  use = "complete.obs"
)

cor

# 1 b) ----
# corrplot erstellen
library("corrplot")
corrplot(
  cor$r, 
  p.mat = cor$p, 
  insig = "blank",
  type = "upper", 
  method = "circle"
)

#  diagonale entfernen.
library("corrplot")
corrplot(
  cor$r, 
  p.mat = cor$p, 
  insig = "blank",
  type = "upper", 
  method = "circle",
  diag = FALSE # beachte Anzahl Spalten/Zeilen
)

# alternative:
cor$r

for (i in 1:dim(cor$r)[1]) {
  for (j in 1:dim(cor$r)[2]) {
    if (i == j) {
      cor$r[i, j] <- NA 
    }
  }
}

cor$r

corrplot(
  cor$r, 
  p.mat = cor$p, 
  insig = "blank",
  type = "upper", 
  method = "circle",
  na.label = "-"
)

# 2. Mittelwertvergleiche education & hhincome ----
#  Grouping von Education
essIt <- essIt %>% 
  mutate(
    eduG = case_when(
      edlveit <= 2 ~ "low", 
      edlveit > 2 & edlveit <= 8 ~ "medium",
      edlveit > 8 & edlveit <= 20 ~ "high", 
      edlveit > 20 & edlveit <= 27 ~ "very high", 
      TRUE ~ NA_character_
    ),
    eduG = factor(eduG)
  )

table(
  essIt$eduG, 
  essIt$edlveit
)

# 2 Gruppen-Test  ----
# t-Test education zwischen high und medium
leveneTest(
  essIt$stfdem,
  essIt$eduG, 
  center = "mean"
)
# keine Varianzgleichheit!

# Variante mit pipe
# install.packages("rstatix")
library("rstatix")
# Deskriptive Statistik
essIt %>% 
  group_by(eduG) %>% 
  select(stfdem) %>% 
  get_summary_stats(
    stfdem, 
    type = "full"
  ) %>% 
  ungroup()

# zwei Gruppen auswählen und neue Variablen erschaffen (erleichtert Formelschreibweise)
essIt <- essIt %>% 
  mutate(
    eduG2 = case_when(
      eduG == "medium" ~ "medium", 
      eduG == "high" ~ "high",
      TRUE ~ NA_character_
    )
  )

levels(essIt$eduG2)

# Levene Test
essIt %>% 
  levene_test(stfdem ~ eduG2)

mcTest <- essIt %>% 
  t_test(
    stfdem ~ eduG2,
    mu = 0,
    alternative = "two.sided",
    paired = FALSE,
    var.equal = FALSE
  )

mcTest

essIt %>% 
  t_test(stfdem ~ eduG2)

# Weitergabe des Ergebnisses
t.test(
  essIt$stfdem ~ essIt$eduG2,
  mu = 0,
  alternative = "two.sided",
  paired = FALSE, 
  var.equal = FALSE
) %>% 
  parameters()

# Alternative ohne Formelschreibweise
# t.test(
#   essIt$stfdem[essIt$eduG == "medium"],
#   essIt$stfdem[essIt$eduG == "high"],
#   mu = 0,
#   alternative = "two.sided",
#   paired = FALSE, 
#   var.equal = FALSE
# ) %>% 
#   parameters()

# t-Tests zwischen allen Ausprägungen auf income ----
str(essIt$hinctnta)
leveneTest(
  essIt$stfdem ~ factor(essIt$hinctnta), 
  center = "mean"
)
# Varianzgleichheit liegt vor

oneway.test(
  essIt$stfdem ~ factor(essIt$hinctnta),
  var.equal = TRUE
) %>% 
  parameters()
# es gibt signifikante Ergebnisse

pairwise.t.test(
  essIt$stfdem,
  factor(essIt$hinctnta),
  var.equal = TRUE, 
  p.adj = "bonferroni"
) %>% 
  parameters()
#  signifikante Unterschiede zwischen Dezilen: 3-1, 4-1, 5-1, 6-1, 7-1, 8-1, 
# 9-1, 8-2, 9-2

#  Alternativer Vorgang
essIt %>% 
pairwise_t_test(
  stfdem ~ hinctnta,
  p.adjust.method = "bonferroni"
) %>% 
  print(n = 100)
