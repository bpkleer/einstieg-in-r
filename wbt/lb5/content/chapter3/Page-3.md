---
title: "ggpairs() nutzen"  # Titel der Seite
weight: 303  # Individuelles Gewicht 
menuTitle: "ggpairs()" # Falls Titel zulang ist, hier Kurztitel
tags: ["ggplot", "ggpairs", "ggally", "korrelation", "advanced"]  # Tags hiereinsetzen; Kurzwort, was auf der Seite passsiert
---

Kommen wir zu deiner Challenge: Du willst im folgenden Zusammenhang von der Zufriedenheit mit der Demokratie und den Variablen `trstprl`, `trstlgl`, `stfeco` und `agea` testen. Probiere dich mit `ggpairs()` aus!

{{< tabs >}}
{{% tab name = "Start" %}}
Probier dich aus, bevor du in die anderen Tabs schaust!
{{% /tab %}}
{{% tab name="ggpairs()" %}}
```R
oneSolution <- ggpairs(
  pss, 
  columns = c(
    "stfdem",
    "trstprl",
    "trstlgl",
    "stfeco"
  ),
  lower = list(
    continuous = wrap(
      "points",
      position = position_jitter(width = 0.5)
    ),
    combo = wrap(
      "facethist",
      binwidth = 1
    )
  ),
  upper = list(
    continuous = "cor",
    combo = "box_no_facet"
  ),
  diag = list(
    continuous = wrap("densityDiag", bw = 1),
    discrete = "barDiag"
  )
) 

oneSolution
```
{{% /tab %}}
{{% tab name="pairs.panels()" %}}
```R
library("psych")

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
```
{{% /tab %}}
{{% tab name="corrplot()" %}}
```R
cor <- corr.test(
  pss[c(
    "stfdem",
    "trstprl",
    "trstlgl",
    "stfeco"
  )
  ],
  method = "pearson",
  use = "complete.obs"
) 

library("corrplot")

corrplot(
  cor$r, 
  p.mat = cor$p,    # Matrix mit p-Werten
  insig = "blank",   # nicht signifikante = leer
  type = "upper",    # auch lower möglich
  method = "circle" # verschiedene Optionen möglich
)   
```
{{% /tab %}}
{{< /tabs >}}

Auf der nächsten Seite kannst du noch eine `ggplot` Alternative zu `corrplot` kennenlernen oder du überspringst diese und gehst über zur Darstellung von Mittelwertvergleichen!