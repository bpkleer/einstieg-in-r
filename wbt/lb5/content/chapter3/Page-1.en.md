---
title: "Distribution"  # Page title
weight: 301  # Custom weight 
menuTitle: "Distribution" # Short title if necessary
tags: ["ggplot", "distribution", "advanced"]  # Tags: abbreviation of content

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

First, you now want to display the variable `stfdem`. Think briefly about how you can represent this variable and try to write the code independently. Only then look at the possible solutions.

{{< tabs groupId="1" >}}
{{% tab name = "Start" %}}
Try it out before looking at the other tabs!
{{% /tab %}}
{{% tab name="Option 1" %}}
```R
barplot <- ggplot(
  pss, 
  aes(stfdem)
) +
  geom_bar() + 
  scale_y_continuous(
    breaks = seq(
      0, 
      900,
      100
    )
  ) +
  scale_x_continuous(
    limits = c(
      -0.5, 
      10.5
    ),
    breaks = seq(
      0,
      10,
      1
    )
  ) +
  geom_text( 
    stat = "count", 
    aes(label= ..count..), 
    vjust = -0.5, 
    size = 3.5,
    color = "darkblue"
  ) +
  labs(
    x = "Zufriedenheit mit der Demkoratie", 
    y = "Häufigkeiten", 
    title = "Verteilung von stfdem")

barplot
```
{{% /tab %}}
{{% tab name="Option 2" %}}
```R
hist <- ggplot(
  pss, 
  aes(stfdem)
) + 
  geom_histogram(
    aes(y = ..density..), 
    color = "lightgray", 
    fill = "gray",
    binwidth = 1 # zusätzliches Argument wg pseudo-metrischen Daten
  ) + 
  geom_density(
    alpha = 0.2, 
    fill = "lightblue",
    bw = 1 # zusätzliches Argument wg pseudo-metrischen Daten (bw = binwidth)
  ) +
  labs(
    x = "Zufriedenheit mit Demokratie", 
    y = "Dichte", 
    title = "Histogramm stfdem (PSS)"
  ) +
  scale_x_continuous(
    breaks = seq(
      0,
      10,
      1
    ),
    limits = c(
      -0.5, 
      10.5
    )
  )

hist
```
{{% /tab %}}
{{< /tabs >}}

Great job if you managed to do that. Now you want to see if there are differences in the variable by gender.

{{< tabs groupId="2" >}}
{{% tab name = "Start" %}}
Try it out before looking at the other tabs!
{{% /tab %}}
{{% tab name="Option 1" %}}
```R
stfdemDistrict <- ggplot(
  pss, 
  aes(
    stfdem, 
    fill = district
  )
) +
  geom_bar(position = position_dodge()) + 
  scale_y_continuous(
    breaks = seq(
      0,
      200, 
      10
    ),
    limits = c(
      0, 
      200
    )
  ) + 
  geom_text(
    stat = "count", 
    aes(label= ..count..), 
    vjust = -1, 
    size = 3.5, 
    position = position_dodge(0.9)
  ) +
  labs(
    x = "Zufriedenheit mit Demkoratie", 
    y = "Häufigkeiten", 
    title = "Zufriedenheit mit der Demokratie nach Distrikt",
    caption = "Data: Panem Social Survey."
  ) +
  scale_fill_manual(
    name = "Distrikt", 
    values = beyonce_palette(26)
  ) +
  facet_grid(~district)

stfdemDistrict
```
{{% /tab %}}
{{% tab name="Option 2" %}}
```R
stfdemDistrict2 <- ggplot(
  pss,
  aes(
    stfdem, 
    fill = district
  )
) +
  geom_histogram(
    aes(y = ..density..),
    alpha = 0.5, 
    binwidth = 1, 
    position = "identity"
  ) + 
  geom_density(
    alpha = 0.2,
    bw = 1
  ) +
  facet_grid(
    .~ district 
  ) + 
  scale_fill_manual(values = beyonce_palette(72)) +
  labs(
    x = "Zufriedenheit mit Demkoratie", 
    y = "Density", 
    title = "Histogramm von stfdem",
    caption = "Data: Panem Social Survey."
  ) + 
  theme(legend.position = "none")

stfdemDistrict2
```
{{% /tab %}}
{{% tab name="Option 3" %}}
```R
stfdemDistrict3 <- ggplot(
  pss, 
  aes(
    stfdem,
    district,
    fill = district
  )
) +
  geom_density_ridges(
    scale = 0.9,
    alpha = 0.4
  ) +
  scale_x_continuous(
    limits = c(
      0,
      10
    ),
    breaks = seq(
      0,
      10,
      1
    )
  ) +
  theme_ridges() +
  theme(legend.position = "none")

stfdemDistrict3
```
{{% /tab %}}
{{< /tabs >}}

Let's move on to correlation visualization!
