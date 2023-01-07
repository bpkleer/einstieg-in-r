###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Skript zu Lernblock 4                                                   #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:  Leon Klemm, B. Philipp Kleer                                    #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        #
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# 1. Lineare Regression ----

# > Bivariates Beispiel ----
pss <- readRDS("./data/pss.rds")
pss

olsModel <- lm(
  stfdem ~ 1 + stfeco, #Formel der Regression
  data = pss # Datenobjekt
)  
olsModel

sumOLS <- summary(olsModel) 
sumOLS

coefOLS <- coef(olsModel)
coefOLS

confintOLS <- confint(olsModel)
confintOLS

coefOLS2 <- olsModel$coefficients # Koeffizienten
coefOLS2

headOLS <- head(olsModel$fitted.values) # geschätzte Werte
headOLS

residOLS <- olsModel$residuals # Residuen
residOLS

headOLS2 <- head(fitted(olsModel)) # ersten 6 geschätzten Werte
headOLS2

residOLS2 <- resid(olsModel) # Residuen
residOLS2


# > Multivariates Beispiel ----
cor1 <- cor(
  pss$trstlgl, 
  pss$stfdem,
  method = "pearson", 
  use = "complete.obs"
)
cor1

olsModel2 <- lm(
  stfdem ~ 1 + stfeco + trstlgl,   
  data = pss
) 
olsModel2

sumOLS2 <- summary(olsModel2)
sumOLS2


# > Dichotome kategorielle Variablen ----
olsModel3 <- lm(
  stfdem ~ 1 + stfeco + trstlgl + gndr,   
  data = pss
)    
olsModel3

sumOLS3 <- summary(olsModel3)
sumOLS3


# > Polytome kategorielle Variablen ----
olsModel4 <- lm(
  stfdem ~ 1 + stfeco + trstlgl + gndr + edu,   
  data = pss
)
olsModel4

sumOLS4 <-summary(olsModel4)
sumOLS4

pss$edu <- relevel(
  pss$edu, 
  ref = "ES-ISCED III"
) 

olsModel5 <- lm(
  stfdem ~ 1 + stfeco + trstlgl + gndr + edu,
  data = pss
)
olsModel5

sumOLS5 <- summary(olsModel5)
sumOLS5


# 2. Standardisierung & Export ----

# > Standardisierte Koeffizienten ----
pss <- pss %>% 
  mutate(
    stfdemZ = scale(stfdem),
    stfecoZ = scale(stfeco),
    trstlglZ = scale(trstlgl)
  )

olsModel2Z <- lm(
  stfdemZ ~ 1 + stfecoZ + trstlglZ,   
  data = pss
)   
olsModel2Z

sumOLS2Z <- summary(olsModel2Z)
sumOLS2Z


# > Export ----
install.packages(
  "modelsummary",
  dependencies = TRUE
)
library("modelsummary")

tabOLS <- modelsummary(olsModel)
tabOLS

tabOLS2 <- modelsummary(
  list(
    olsModel, 
    olsModel2
  )
)
tabOLS2

models <- list(
  olsModel, 
  olsModel2
)
models

tabOLS3 <- modelsummary(models)
tabOLS3

# >> Ausgabeformate ----
tabWord <- modelsummary(
  models, 
  output = "table.docx" # Word-Datei (package flextable nötig)
)
tabWord

tabHTML <- modelsummary(
  models, 
  output = "table.html" # HTML-Datei
)
tabHTML

tabTex <- modelsummary(
  models, 
  output = "table.tex" # Tex-Datei
)
tabTex

tabMD <- modelsummary(
  models, 
  output = "table.md" # Markdown-Datei
)
tabMD

tabText <- modelsummary(
  models, 
  output = "table.txt" # Text-Datei 
)
tabText

tabPNG <- modelsummary(
  models, 
  output = "table.png" # Bild-Datei 
)
tabPNG

tabHTML2 <- modelsummary(
  models, 
  output = "html"
)
tabHTML2

tabTex2 <- modelsummary(
  models, 
  output = "latex"
)
tabTex2

tabMD2 <- modelsummary(
  models, 
  output = "markdown"
)
tabMD2

# >> Ausgabe anpassen ----

# 4 Dezimalstellen nach dem Dezimaltrennzeichen
tabEd1 <- modelsummary(
  models, 
  fmt = 4
)
tabEd1

tabEd2 <- # 4 Dezimalzeichen und 0 am Ende
  modelsummary(
    models, 
    fmt = "%.4f"
  )
tabEd2

# wissenschaftliche Notation
tabEd3 <- modelsummary(
  models, 
  fmt = "%.4e"
)
tabEd3


options(OutDec = ",")

tabEd4 <- modelsummary(
  olsModel, 
  fmt = 2
)
tabEd4

options(OutDec = ".")

tabEd5 <- modelsummary(
  models,
  fmt = 1,
  estimate  = "{estimate} [{conf.low}, {conf.high}]",
  statistic = NULL
)
tabEd5

tabEd6 <- modelsummary(
  models,
  fmt = 1,
  estimate  = "{estimate}{stars}",
  statistic = NULL
)
tabEd6

tabEd7 <- modelsummary(
  models,
  fmt = 1,
  estimate  = "{estimate}{stars}",
  statistic = NULL,
  notes = list('$^{*} p< 0.1$, $^{**} p<0.05$, $^{***} p<0.01$')
)
tabEd7

tabEd8 <- modelsummary(
  models, 
  stars = TRUE # standardmäßig an!
) 
tabEd8

tabEd9 <- modelsummary(
  models,
  fmt = 1,
  estimate  = "{estimate}{stars}",
  statistic = "[{conf.low}, {conf.high}]"
)
tabEd9

tabEd10 <- modelsummary(
  models,
  fmt = 1,
  stars = TRUE,
  statistic = "conf.int", 
  conf_level = .95
)
tabEd10

tabEd11 <- modelsummary(
  models, 
  statistic = c("conf.int",
                "s.e. = {std.error}", 
                "t = {statistic}",
                "p = {p.value}"
  )
)
tabEd11

tabEd12 <- modelsummary(
  models, 
  coef_rename=c("stfeco" = "Zufriedenheit Ökonomie", 
                "trstlgl" = "Vertrauen Rechtssystem"
  )
)
tabEd12


# >> Dotwhisker ----
install.packages("dotwhisker")

library("dotwhisker")

dw1 <- dwplot(olsModel2)
dw1

dw2 <- dwplot(
  list(
    olsModel,
    olsModel2
  )
)
dw2


dw3 <- dwplot(
  list(
    olsModel, 
    olsModel2
  )
) +
  # Linie bei 0
  geom_vline(
    xintercept = 0,
    linetype = "dashed"
  ) +
  # Renaming der y-Achse
  scale_y_discrete(labels = rev(
    c(
      "Zufriedenheit \n Ökonomie", 
      "Vertrauen \n Rechtssystem"
    )
  )
  ) + 
  # x-Achse modifiziert
  scale_x_continuous(
    breaks = seq(
      -1, 
      1,
      0.2
    ),
    limits = c(-1, 1)
  ) +
  # Titel und Caption hinzugefügt
  labs(title = "Lin. Regressionsmodelle auf stfdem",
       caption = "Data: Panem Social Survey."
  )
dw3



# 3. Regressionsdiagnostik ----

# > Lineare Beziehung ----
linPlot <- plot(
  olsModel2,
  1
)
linPlot

# > Normalverteilung Residuen ----
resPlot <- plot(
  olsModel2,
  2
)
resPlot

resPlot2 <- plot(density(olsModel2$residuals))
resPlot2

resPlot3 <- curve(
  dnorm(
    x, 
    0, 
    summary(olsModel2)$sigma
  ), 
  add = TRUE,
  col = "green", 
  lwd = 2
)
resPlot3

# > Homoskedastizität ----
homPlot <- plot(
  olsModel2, 
  3
)
homPlot

homPlot2 <- ggplot(
  olsModel2, 
  aes(.fitted, 
      sqrt(abs(.stdresid))
  )
) + 
  geom_point(na.rm = TRUE) +
  geom_jitter(
    width = 0.35,
    height = 0.35
  ) +
  stat_smooth(
    method = "loess",
    na.rm = TRUE,
    se = FALSE
  ) + 
  xlab("Fitted Values") + 
  ylab(expression(sqrt("Standardized residuals"))) + 
  ggtitle("Scale-Location")
homPlot2

library("lmtest")

bpt <- bptest(olsModel2)
bpt


install.packages("robustbase")
library("robustbase")

# Just use function lmrob() as lm()
olsModel2rob <- lmrob(
  stfdem ~ 1 + stfeco + trstlgl,
  data = pss
)
olsModel2rob

sumOLS2rob <- summary(olsModel2rob)
sumOLS2rob


# > Autokorrelation ----

# lagged regression
res <- olsModel2$res  
res

n <- length(res)  
n

testmodel <- lm(res[-n] ~ res[-1]) 
testmodel

sumTestmodel <- summary(testmodel)
sumTestmodel

# Durbin-Watson-Test
dwt <- dwtest(olsModel2)
dwt

# Breusch-Godfrey-Test
bgt <- bgtest(
  olsModel2,
  order = 1
) 
bgt

# Grafische Analyse
resPlot4 <- plot(olsModel2$residuals)


# > Multikollinearität ----
install.packages("car")
library("car")

vifOLS <- vif(olsModel2)
vifOLS


# > Einflussreiche Fälle ----
cooksPlot <- plot(
  olsModel2,
  4
)
cooksPlot


levPlot <- plot(
  olsModel2, 
  6
)
levPlot

levPlot2 <- abline(
  h = 3 * mean(cooks.distance(olsModel2), na.rm = TRUE), 
  col = "chartreuse4", 
  lty = 6,  # Grenze Cook's D
  lwd = 2
)
levPlot2

levPlot3 <- abline(
  v = 2 * (2 + 1) / 2393, 
  col = "chartreuse4", 
  lty = 6,  # Grenze leverage
  lwd = 2
) 
levPlot3

nOLS <- nobs(olsModel2)

ccol <- c(
  "stfdem",
  "stfeco",
  "trstlgl"
) 
ccol

pss2 <- pss[complete.cases(pss[,ccol]),]
pss2

dimPSS <- dim(pss2)
dimPSS

pss2$hats <- hatvalues(olsModel2)    

pss2$cooksd <- cooks.distance(olsModel2)

for (i in 1:dim(pss2)[1]) {   
  if (pss2$hats[i] > (2*(2+1)/dim(pss2)[1])) {
    pss2$leverage[i] = 1
  } else {
    pss2$leverage[i] = 0
  }
}

for (i in 1:dim(pss2)[1]) {
  if (pss2$cooksd[i] > (3*mean(pss2$cooksd))) {
    pss2$influence[i] = 1
  } else {
    pss2$influence[i] = 0
  }
}

olsModel2Re <- lm(
  stfdem ~ 1 + stfeco + trstlgl,  
  data = pss2[pss2$leverage==0 & pss2$influence==0,]
)
olsModel2Re

nOmit <- nobs(olsModel2Re) - nobs(olsModel2)
nOmit

sumOLSre <- summary(olsModel2Re)
sumOLSre

modsum <- modelsummary(
  list(
    olsModel2, 
    olsModel2Re
  ),
  stars = TRUE
)
modsum

levInfluential <- c()
cookInfluential <- c()
allInfluential <- c()

# nur für leverage
for (i in 1:dim(pss2)[1]) {
  if (pss2$leverage[i] == 1) {
    levInfluential <- c(levInfluential, pss2$idno[i])
  }
}

# nur für Cook's D
for (i in 1:dim(pss2)[1]) {
  if (pss2$influence[i] == 1) {
    cookInfluential <- c(cookInfluential, pss2$idno[i])
  }
}

# für beides
for (i in 1:dim(pss2)[1]) {
  if (pss2$leverage[i] == 1 & pss2$influence[i] == 1) {
    allInfluential <- c(allInfluential, pss2$idno[i])
  }
}

levInfluential

cookInfluential

allInfluential