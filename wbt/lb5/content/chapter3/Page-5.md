---
title: "Mittelwertvergleiche"  # Titel der Seite
weight: 305  # Individuelles Gewicht 
menuTitle: "Mittelwertvergleich" # Falls Titel zulang ist, hier Kurztitel
tags: ["ggplot", "mittelwertvergleich", "advanced"]  # Tags hiereinsetzen; Kurzwort, was auf der Seite passsiert
---

{{% buttonGit href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-r/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonGit %}} 

{{% buttonGit href="https://twitter.com/share?url=" icon="fab fa-twitter" %}} {{% /buttonGit %}}

{{% buttonGit href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonGit %}}

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