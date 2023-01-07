# Meine Forschungsfrage: 
# Inwieweit lässt sich die Zufriedenheit mit der Demokratie (`stfdem`)
# durch andere Zufriedenheitswerte (`stfeco`, `stfhlth`, `stfedu`) 
# unter Kontroll von sozioökonomischen Variablen erlkären
# (z.B. `hinctnta`, `gndr`, `agea`)? 
# 5 gewählte metrische Variablen
# stfeco, stfhlth, stfedu, agea, hinctnta
# 2 gewählte kategorielle Variablen
# education & gndr

# > Vorbereitungen ----
# libraries
library("tidyverse")
library("parameters")
library("modelsummary")
library("dotwhisker")

# Datensatz laden
essIt <- readRDS("../data/essIt.rds")

# Rekodierungen gndr & edulveit
essIt <- essIt %>% 
  mutate(
    eduG = case_when(
      edlveit <= 2 ~ "low", 
      edlveit > 2 & edlveit <= 8 ~ "medium",
      edlveit > 8 & edlveit <= 21 ~ "high",
      TRUE ~ NA_character_
    ),
    eduG = factor(eduG),
    gndr = factor(
      essIt$gndr,
      labels = c(
        "female", 
        "male"
      )
    )
  )

# um robustheit zu testen
essIt$hinctnta2 <- factor(
  essIt$hinctnta
)

# Referenze middle categorie
relevel(
  essIt$hinctnta2,
  ref = 5
)

# > Modelle ----
# Nullmodell
model0 <- lm(
  stfdem ~ 1, 
  data = essIt
)

# Modell 1
model1 <- lm(
  stfdem ~ 1 + stfeco + stfhlth + stfedu, 
  data = essIt
)

# Modell 2
model2 <- lm(
  stfdem ~ 1 + stfeco + stfhlth + stfedu + agea + gndr + hinctnta + eduG, 
  data = essIt
)

# Modell 3 (Test Einkommen als kategoriale Variable)
model3 <- lm(
  stfdem ~ 1 + stfeco + stfhlth + stfedu + agea + gndr + hinctnta2 + eduG, 
  data = essIt
)

summary(model3)


# > Modellübersicht ----
models <- list(
  model0, 
  model1, 
  model2
)

modelsummary(
  models,
  stars = TRUE
)

# Plot
dwplot(
  list(
    model0, 
    model1, 
    model2
  )
)