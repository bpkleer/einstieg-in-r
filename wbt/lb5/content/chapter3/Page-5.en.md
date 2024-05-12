---
title: "Mean Comparisons"  # Page title
weight: 305  # Custom weight 
menuTitle: "Mean Comparison" # Short title if the title is too long
tags: ["ggplot", "mean comparisons", "advanced"]  # Insert tags here; abbreviation of what happens on the page
---

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

Now we want to present mean comparisons. A good way to do this is with *Rainclouds* (which you have already learned about) and try to create *rainclouds* for the following problem:

{{< tabs >}}
{{% tab name="Question" %}}
You now want to test if satisfaction with democracy differs by district. You have calculated a mean comparison and now want to graphically represent this as well.
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

Next up, we move on to regressions!
