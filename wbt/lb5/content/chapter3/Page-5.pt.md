---
title: "Comparação de Médias"  # Título da página
weight: 305  # Peso individual
menuTitle: "Comparação de Médias" # Se o título for muito longo, use um título curto aqui
tags: ["ggplot", "comparação de médias", "avançado"]  # Insira as tags aqui; Abreviação do que acontece na página
---

{{% buttonShare href="https://gitlab.ub.uni-giessen.de/methoden-politik/einstieg-in-statistik/issues/new?issue[title]=" icon="fas fa-bug" %}} {{% /buttonShare %}} 

{{% buttonShare href="mailto:" icon="fas fa-paper-plane" %}} {{% /buttonShare %}}

{{% buttonShare href="https://t.me/share/url?url=" icon="fab fa-telegram" %}} {{% /buttonShare %}}

{{% buttonShare href="https://api.whatsapp.com/send?text=" icon="fab fa-whatsapp" %}} {{% /buttonShare %}}

{{% buttonShare href="https://twitter.com/share?url=" icon="fab fa-x-twitter" %}} {{% /buttonShare %}}

{{% buttonShare href="https://www.facebook.com/sharer/sharer.php?u=" icon="fab fa-facebook" %}} {{% /buttonShare %}}

{{% button href="https://bmc.link/bpkleerw" icon="fa-solid fa-beer-mug-empty" %}} {{% /button %}}

Agora vamos representar as comparações de médias. Uma boa maneira são as *Rainclouds* (você já as conheceu) e vamos tentar criar *rainclouds* para o seguinte problema:

{{< tabs >}}
{{% tab name="Pergunta" %}}
Agora você quer testar se a satisfação com a democracia difere por distrito, para isso você calculou uma comparação de médias, mas agora também deseja representar graficamente isso.
{{% /tab %}}
{{% tab name="Solução 1" %}}
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
{{% tab name="Solução 2" %}}
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

Vamos continuar com as regressões!
