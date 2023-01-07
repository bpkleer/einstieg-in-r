

# Vorbereitungen
library("essurvey")
library("tidyverse")
library("foreign")

# set your email
set_email("your registered email")

# download round 9
ess9 <- essurvey::import_rounds(9)

# import mit foreign
examspss <- read.spss(
  "./data/ess9.sav", 
  use.value.labels = FALSE,       
  to.data.frame = TRUE
)            

# Meine Forschungsfrage: 
# Inwieweit lässt sich die Zufriedenheit mit der Demokratie (`stfdem`)
# durch wirtschaftliche und soziostrukturelle Merkmale erklären (z.B. `stfeco`,
# `hinctnta`, `edulvlb`, `gndr`)?

# 1. Beschränke den Datensatz so, dass du nur noch die Fälle aus dem ausgesuchten 
#    Land vorfindest!
ess9 <- ess9 %>% 
  filter(cntry == "")

# 2. Wie viele Fälle hat der Datensatz nun noch?
dim(ess9)[1]
length(ess9$stflife)

# 3. Lass dir sinnvolle Lage-/Streumaße für die Variable deine gewählte 
#    **abhängige Variable** ausgeben. Beschreibe die Verteilung auch als Kommentar!
#    Wie verhalten sich die zentralen Maße zueinander? (*linksschief, rechtsschief,
#    normalverteilt, bimodal?*)
summary(ess9$stfdem)

# Problem hier, dass es Factor ist und daher nicht sinnvoll verarbeitet werden kann.

summary(
  as.numeric(ess9$stfdem)
)

sd(
  as.numeric(ess9$stfdem),
  na.rm = TRUE
)

var(
  as.numeric(ess9$stfdem),
  na.rm = TRUE
)

IQR(
  as.numeric(ess9$stfdem),
  na.rm = TRUE
)


# 4. Finde heraus, was die Variable `lrscale` wiedergibt. Gruppiere die Variable
#    in drei Gruppen und speicher dies in der neuen Variable `lrscaleG`. Lass 
#    dir anschließend den Mittelwert deiner gewählten **abhängigen Variable** 
#    in Abhängigkeit der geschaffenen Gruppen ausgeben. Was kannst du erkennen?
str(ess9$lrscale)
table(as.numeric(ess9$lrscale))

ess9 <- ess9 %>% 
  mutate(
    lrscale = as.numeric(lrscale), 
    lrscaleG = case_when(
      lrscale <= 4 ~ 0, 
      lrscale > 4 & lrscale <= 7 ~ 1, 
      lrscale > 7 ~ 2
    )
  )

table(
  ess9$lrscale, 
  ess9$lrscaleG
)

ess9 %>% 
  group_by(lrscaleG) %>% 
  summarize(mean = mean(as.numeric(stfdem), na.rm=TRUE))

# 5. Die Variable `edulvlb` gibt das Bildungslevel der Befragten an. Für unseren 
#    Zweck ist die Aufteilung aber zu detailliert. Überlege dir, wie du Gruppen
#    zusammenfassen kannst und speichere dies in der neuen Variable `eduG` im
#    Datensatz! Begründe deine Zusammenfassung.
levels(ess9$edulvlb)

ess9 <- ess9 %>% 
  mutate(
    eduH = as.numeric(edulvlb),
    eduG = case_when(
      eduH <= 2 ~ "low", 
      eduH > 2 & eduH <= 8 ~ "medium",
      eduH > 8 & eduH <= 20 ~ "high", 
      eduH > 20 & eduH <= 27 ~ "very high", 
      TRUE ~ NA_character_
    )
  )

table(
  ess9$eduG, 
  ess9$edulvlb
)

ess9 %>% 
  group_by(eduG) %>% 
  summarize(mean = mean(as.numeric(trstprl), na.rm=TRUE))

# 6. Die Variable `wkhtot` gibt an, wie viel Stunden pro Woche eine Person 
#    arbeitet. Nun möchtest du für eine Analyse zwischen Personen, die $< 20$ 
#    Stunden und Personen die $\geq 20$ Stunden arbeiten. Schaffe eine neue 
#    Variable `wkhtotG`, die anzeigt, ob eine Person $\geq 20$ Stunden arbeitet
#    oder nicht. Lass dir anschließend den Mittelwert deiner **abhängigen 
#    Variable** in Abhängigkeit der neu geschaffenen Gruppen ausgeben. 
ess9 <- ess9 %>% 
  mutate(
    wkhtotG = case_when(
      wkhtot <= 20 ~ 1, 
      wkhtot > 20 ~ 2
    )
  )

table(
  ess9$wkhtot, 
  ess9$wkhtotG
)

ess9 %>% 
  group_by(wkhtotG) %>% 
  summarize(mean = mean(as.numeric(stfdem), na.rm=TRUE))

# 7. In der Variable `region` sind die Regionen eines Landes dargestellt. Finde 
#    heraus, welche Regionen zu dem ausgewählten Land gehören. Erstelle jeweils 
#    ein eigenes Objekt, das nur die Daten einer Region des Landes beinhaltet.
essDE1 <- ess9 %>% 
  filter(region == "DE1")

# repeated for DE2 DE3 DE4 DE5 DE6 DE7 DE8 DE9 DEA DEB DEC DED DEE DEF DEG 

# oder for-schleife
reg <- levels(
  as.factor(
    ess9$region[ess9$cntry=="DE"]
  )
)

reg

essDE <- list()

for (i in 1:16) {
  essDE[[i]] <- ess9 %>% 
    filter(region == reg[i])
}

essDE

# 8. Nun machst du den Schritt rückgängig und führst die einzelnen Datensätze 
#    für die Regionen wieder in einem einzigen Datensatz für das Land zusammen. 
essAll <- essDE[[1]] %>%
  bind_rows(
    list(
      essDE[[2]],
      essDE[[3]],
      essDE[[4]],
      essDE[[5]],
      essDE[[6]],
      essDE[[7]],
      essDE[[8]],
      essDE[[9]],
      essDE[[10]],
      essDE[[11]],
      essDE[[12]],
      essDE[[13]],
      essDE[[14]],
      essDE[[15]],
      essDE[[16]]
    )
  )

essAll <- data.frame()

for (i in 1:16) {
  essAll <- essAll %>% 
    bind_rows(essDE[[i]])
}
