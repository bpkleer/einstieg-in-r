---
title: "Mittelwertvergleiche"  # Titel der Seite
weight: 305  # Individuelles Gewicht 
menuTitle: "Mittelwertvergleich" # Falls Titel zulang ist, hier Kurztitel
tags: ["ggplot", "mittelwertvergleich", "advanced"]  # Tags hiereinsetzen; Kurzwort, was auf der Seite passsiert
---

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:?subject=Schau%20dir%20das%20mal%20an%3A%20" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

Jetzt wollen wir Mittelwertvergleiche darstellen. Eine gute Möglichkeit sind *Rainclouds* (diese hast du schon kennengelernt) und versuchen für folgendes Problem *rainclouds* zu erstellen:

{{< tabs >}}
{{% tab name="Frage" %}}
Du willst jetzt testen, ob sich die Zufriedenheit mit der Demokratie nach Distrikt unterscheidet, dazu hast du einen Mittelwertvergleich gerechnet, möchtest dies jetzt aber auch noch grafisch darstellen. 
{{% /tab %}}
{{% tab name="Solution 1" %}}
```R
ggplot(
  pss, 
  aes(
    x = district, 
    y = stfdem
  )
) + 
  stat_halfeye(
    adjust = 1, 
    width = .4, 
    justification = -.2, 
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .12, 
    outlier.color = NA 
  ) +
  geom_half_point(
    side = "l", 
    shape = 95,
    range_scale = 0,
    size = 10, 
    alpha = .2
  ) +
  scale_y_continuous(
    breaks = seq(
      0, 
      10, 
      1
    )
  )
```
{{% /tab %}}
{{% tab name="Solution 2" %}}
```R
ggplot(
  pss, 
  aes(
    x = district, 
    y = stfdem
  )
) + 
  stat_halfeye(
    adjust = 1, 
    width = .4, 
    justification = -.2, 
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .12, 
    outlier.color = NA 
  ) +
  geom_half_point(
    side = "l", 
    range_scale = .4, 
    alpha = .3
  ) +
  scale_y_continuous(
    breaks = seq(
      0, 
      10, 
      1
    )
  )
```
{{% /tab %}}
{{< /tabs >}}

Weiter geht's zu Regressionen!