---
title: "Using ggpairs()"  # Page title
weight: 303  # Custom weight 
menuTitle: "ggpairs()" # Short title if needed
tags: ["ggplot", "ggpairs", "ggally", "correlation", "advanced"]  # Tags: brief description of page content
---

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

Let's move on to your challenge: You want to test the relationship between satisfaction with democracy and the variables `trstprl`, `trstlgl`, `stfeco`, and `agea`. Try using `ggpairs()`!

{{< tabs >}}
{{% tab name = "Start" %}}
Try it out before looking at the other tabs!
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

On the next page, you can explore a `ggplot` alternative to `corrplot`, or you can skip ahead to comparing means!
