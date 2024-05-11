---
title: "ggpairs() nutzen"  # Titel der Seite
weight: 303  # Individuelles Gewicht 
menuTitle: "ggpairs()" # Falls Titel zulang ist, hier Kurztitel
tags: ["ggplot", "ggpairs", "ggally", "korrelation", "advanced"]  # Tags hiereinsetzen; Kurzwort, was auf der Seite passsiert
---

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

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
