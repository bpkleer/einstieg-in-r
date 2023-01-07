###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Skript zur Einheit 13                                                   #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   M. Schulz-Narres, B. Philipp Kleer                             #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) # #                                                                         #
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Balkendiagramme ----
# > Balkendiagramme erstellen ----
library("tidyverse")

# library("ggplot2")

# leeres Plot
plot1 <- ggplot(
  data = pss,
  mapping = aes(x = edu)
)
plot1 

#Balkendiagramm
barplot1 <- ggplot(
  data = pss,
  mapping = aes(x = edu)
) +
  geom_bar()

barplot1

#Balkendiagramm mit Prozenten
barplot2 <- ggplot(
  data = pss, 
  mapping = aes(
    x = edu, 
    y = ..prop.., 
    group = 1
  )
) + 
  geom_bar()

barplot2

#Balkendiagramm drehen
barplot1 + 
  coord_flip()

# > Diagramme bearbeiten ----

# Randlinien färben
barplot <- ggplot(
  pss, 
  aes(
    edu, 
    color = edu
  )
) +
  geom_bar()

barplot

#Balken füllen
barplot <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) +
  geom_bar() 

barplot

#Farben bestimmen
barplot <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) +
  geom_bar(
    fill = c(
      "steelblue", 
      "darkgoldenrod",
      "seagreen", 
      "red4", 
      "orange",
      "darkslategray2"
    )
  ) 

barplot

# Vektor mit Farben
educol = c(
  "steelblue", 
  "darkgoldenrod",
  "seagreen", 
  "red4", 
  "orange",
  "darkslategray2"
)

# Plot mit Farb-Vektor füllen
barplot <- ggplot(
  pss, 
  aes(
    x = edu, 
    fill = edu
  )
) +
  geom_bar(fill = educol) 

barplot

# Farbvektor mit Farbcodes
cbp1 <- c(
  "#999999", 
  "#E69F00",
  "#56B4E9",
  "#009E73",
  "#F0E442", 
  "#0072B2",
  "#D55E00",
  "#CC79A7"
)

#Plot mit Farbvektor füllen
barplotCb <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) + 
  geom_bar() +
  scale_fill_manual(values = cbp1)

barplotCb

# Plot mit Graustufen füllen
barplotGray <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) + 
  geom_bar() +
  scale_fill_grey()

barplotGray

# >> Entwicklertool für Beyonce-Paletten---- 
# Installation Entwicklertool
install.packages(
  "devtools",
  dependencies = TRUE
)

# Install beyonce palette
devtools::install_github("dill/beyonce")

# Install zusätzliche Farbpaletten
install.packages("RColorBrewer")

library("RColorBrewer")

display.brewer.all()

barplotBrewer <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) + 
  geom_bar() +
  scale_fill_brewer(palette = "Dark2")

barplotBrewer


library("beyonce")
# Ausgabe aller Farbpaletten [beginnend bei 1]
par(mfrow=c(26,5))
for(i in 1:130) print(beyonce_palette(i))

barplotBeyonce <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) +
  geom_bar() +
  scale_fill_manual(values = beyonce_palette(25)) 

barplotBeyonce

# Beschriftungen der Balken
barplotBeyonce +
  geom_text(
    stat = "count", 
    aes(label =  ..count..)
  )

barplotBeyonce +
  geom_text(
    stat = "count", 
    aes(label = ..count..), 
    vjust = 1.5, 
    color = "white"
  )

barplotBeyonce +
  geom_text(
    stat = "count", 
    aes(label = ..count..), 
    vjust = 1.5, 
    size = 8,
    color = "white"
  )

# y-Achse ändern
barplotBeyonce <- barplotBeyonce +
  geom_text(
    stat = "count", 
    aes(label = ..count..), 
    vjust = -2.5, 
    size = 8,
    color = "white"
  ) +
  scale_y_continuous(
    limits = c(
      0, 
      1750
    )
  )

barplotBeyonce

# Achsenmarkierungen ändern
barplotBeyonce <- barplotBeyonce + 
  scale_y_continuous(
    breaks = seq(
      0, 
      1750, 
      100
    ),
    limits = c(
      0,
      1750
    )
  )

barplotBeyonce

# x-Achse ändern
barplotBeyonce <- barplotBeyonce + 
  scale_x_discrete(
    limits = c(
      "ES-ISCED I", 
      "ES-ISCED II",
      "ES-ISCED III",
      "ES-ISCED IV",
      "ES-ISCED V", 
      NA
    )
  ) 

barplotBeyonce

# Legende bearbeiten
barplotBeyonce +
  theme(legend.position = "bottom") # left, right, top oder none

barplotBeyonce

barplotBeyonce + 
  scale_fill_manual(
    name = "Bildungsniveau",
    labels = c(
      "sehr niedrig", 
      "niedrig",
      "mittel",
      "hoch",
      "sehr hoch", 
      "NA"
    ),
    values = beyonce_palette(25)
  )

barplotBeyonce

# Achsenbeschriftung und Titel
barplotBeyonce + 
  labs(
    x = "Bildungsniveau", 
    y = "Häufigkeiten",
    title = "My first try with ggplot2"
  )


# Finales Plot mit allen Anpassungen
barplotFinal <- ggplot(
  pss, 
  aes(
    edu, 
    fill = edu
  )
) +
  geom_bar() + 
  scale_y_continuous(
    breaks = seq(
      0, 
      1750,
      100
    )
  ) +
  scale_x_discrete(
    limits = c(
      "ES-ISCED I", 
      "ES-ISCED II",
      "ES-ISCED III",
      "ES-ISCED IV",
      "ES-ISCED V"
    )
  ) + 
  scale_fill_manual(
    name = "Bildungsniveau",
    labels = c(
      "sehr niedrig", 
      "niedrig",
      "mittel",
      "hoch",
      "sehr hoch"
    ),
    values = beyonce_palette(25)
  ) +
  geom_text( 
    stat = "count", 
    aes(label= ..count..), 
    vjust = -0.5, 
    size = 3.5,
    color = "darkblue"
  ) +
  labs(
    x = "Bildungsniveau", 
    y = "Häufigkeiten", 
    title = "My first fancy ggplot ohne NA")

barplotFinal

# > Speichern von Plots ----
getwd()

ggsave(
    "./img/mffggplot.png",  
    width = 8,        
    height = 6,
    units = "in",     
    dpi = 450
)   

# > Gruppieren----
# Weitere Variable hinzufügen
str(pss$gndr)

barGroup <- ggplot(
  pss, 
  aes(
    edu, 
    fill = gndr
  )
) +
  geom_bar()

barGroup

# Teilbalken nebeneinander positionieren
barGroup <- ggplot(
  pss, 
  aes(
    edu, 
    fill = gndr
  )
) +
  geom_bar(position = position_dodge())

barGroup

# Plot fertistellen
barGroup + 
  scale_y_continuous(
    breaks = seq(
      0,
      800, 
      100
    ),
    limits = c(
      0, 
      800
    )
  ) + 
  geom_text(
    stat = "count", 
    aes(label = ..count..), 
    vjust = -1, 
    size = 3.5, 
    position = position_dodge(0.9)
  ) +
  labs(
    x = "Bildungslevel", 
    y = "Häufigkeiten", 
    title = "My first fancy ggplot"
  ) +
  scale_fill_manual(
    name = "Gender", 
    labels = c(
      "Female", 
      "Male"
    ),
    values = beyonce_palette(72)
  )

barGroup

# Histogramme ----


# Boxplots ----

# Scatterplots ----

# Erweiterungen ----
# > Layout ---- 
# Scatterplot aus der Einführung erstellen
scatter <- ggplot(
  pss, 
  aes(
    stfeco, 
    stfdem
  )
) +  
  geom_jitter(
    alpha = .2, 
    col = "blue"
  ) +
  scale_x_continuous(
    breaks = seq(
      0, 
      10, 
      1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      0, 
      10, 
      1
    )
  )

scatter

# Hinzufügen Titel, Achsenbeschriftung und Quellen
scatterLeg <- scatter +
  labs(
    x = "Satisfaction with Economy",
    y = "Satisfaction with Democracy",
    title = "Correlation Plot",
    caption = "Data: Panem Social Survey.\n Data jittered."
  )

scatterLeg

# >> Teilbereiche von Plots ändern ----
scatterLeg +
  theme(
    plot.title = element_text(
      size = 25,
      face = "italic",
      hjust = 0.5
    )
  )
scatterLeg

# Achsentitel
scatterAxes <- scatterLeg +
  theme(
    plot.title = element_text(
      size = 25,
      face = "italic",
      hjust = 0.5
    ),
    axis.title.x = element_text(
      size = 16, 
      color = "seagreen", 
      hjust = 0
    ),
    axis.title.y = element_text(
      size = 8, 
      color = rgb(
        0, 
        105, 
        179, 
        maxColorValue = 255
      ), 
      hjust = 1, 
      face = "bold"
    )
  )

scatterAxes

# Färben
scatterLeg +
  theme(
    plot.title = element_text(
      size = 25,
      face = "italic",
      hjust = 0.5
    ),
    axis.title.x = element_text(
      size = 16, 
      color = "seagreen", 
      hjust = 0
    ),
    axis.title.y = element_text(
      size = 8, 
      color = "#0069B3", 
      hjust = 1, 
      face = "bold"
    )
  )

scatterLeg

# >> Achsenticks ----
scatterTicks <- scatterAxes +
  theme(
    axis.text.x = element_text(
      size = 12, 
      angle = 45,
      color = "darkgrey"
    ),
    axis.text.y = element_text(
      size = 11, 
      hjust = 0,
      vjust = 1
    )
  )

scatterTicks

# >> Achsenbeschriftungen drehen ----
scatterGrid <- scatterTicks +
  theme(
    panel.grid = element_line(
      color = "green",
      size = 1,
      linetype = "solid" # blank, solid, dashed, dotted, dotdash, longdash, twodash 
    )
  )

scatterGrid

# >> Haupt- und Hilfslinien
scatterGrid <- scatterTicks +
  theme(
    panel.grid.major = element_line(
      color = "green",
      size = 1,
      linetype = "solid" # blank, solid, dashed, dotted, dotdash, longdash, twodash 
    ),
    panel.grid.minor = element_blank()
  )

scatterGrid

# >> Hintergrund bearbeiten ----
scatterGrid +
  theme(
    plot.background = element_rect(
      color ="darkgray",
      size = 2,
      fill = "lightpink"
    ),
    panel.background = element_rect(
      fill = "moccasin"
    )
  )
scatterGrid

# > Annotations ----
# Datenbeschriftungen
scatter2 <- ggplot(
  pss[1:15,], 
  aes(
    stfeco, 
    stfdem
  )
) +  
  geom_point(col = "blue") +
  scale_x_continuous(
    breaks = seq(
      0, 
      10,
      1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      0, 
      10, 
      1
    )
  )

scatter2

# ID-Variable als Bechriftung
scatter2 +
  geom_text(
    aes(label = idno)
  )
scatter2

# Schriftstart auf Achse
scatter2 +
  geom_text(
    aes(label = idno),
    size = 2, 
    nudge_y = -.15
  )
scatter2

# Datenpunkte spezifizieren
plot2 <- ggplot(
  pss, 
  aes(
    stfeco, 
    stfdem
  )
) +  
  geom_point(
    alpha = .2, 
    col = "blue"
  ) +
  scale_x_continuous(
    breaks = seq(
      0, 
      10,
      1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      0, 
      10,
      1
    )
  ) +
  geom_text(
    aes(label = idno), 
    data = pss[1:10,]
  )
plot2

# annotate
scatter2 +
  annotate(
    "rect", 
    xmin = 8.5, # this corresponds to the axis scale!
    xmax = 9.5,
    ymin = 8.5,
    ymax = 10.5,
    colour = "darkgreen",
    fill = "lightgreen"
  )
scatter2

# ggplot und annotate
scatter2 +
  annotate(
    "rect", 
    xmin = 8.5, # this corresponds to the axis scale!
    xmax = 9.5,
    ymin = 8.5,
    ymax = 10.5,
    colour = "darkgreen",
    fill = "lightgreen",
    alpha = .1
  )
scatter2

# Grafik beschriften
scatter2 +
  annotate(
    "rect", 
    xmin = 8.5, 
    xmax = 9.5,
    ymin = 8.5,
    ymax = 10.5,
    colour = "darkgreen",
    fill = "lightgreen",
    alpha = .1
  ) +
  annotate(
    "text", 
    x = 1, 
    y = 9, 
    label = "highlighted area", # with \n you get a new line
    colour = "darkgreen"
  ) 
scatter2

# Linien mit annotate
scatter2 +
  annotate(
    "rect", 
    xmin = 8.5, 
    xmax = 9.5,
    ymin = 8.5,
    ymax = 10.5,
    colour = "darkgreen",
    fill = "lightgreen",
    alpha = .1
  ) +
  annotate(
    "text", 
    x = 1, 
    y = 9, 
    label = "highlighted area", # with \n you get a new line
    color = "darkgreen"
  ) +
  annotate(
    "segment", 
    x = 2,
    xend = 8.5, 
    y = 9, 
    yend = 9,
    color = "darkgreen",
    arrow = arrow()
  )
scatter2

# > Missing Values ----
install.packages("UpSetR")
install.packages("naniar")

library("UpSetR")
library("naniar")

# Missings pro Spalte anzeigen lassen
missingValues <- pss %>%
  select(
    c(
      "idno", 
      "stfdem",
      "stfeco", 
      "trstprl", 
      "trstlgl"
    )
  ) %>% 
  pivot_longer(
    everything(),
    names_to = "variable",
    values_to = "val"
  ) %>%
  mutate(is.missing = is.na(val)) %>%
  group_by(
    variable, 
    is.missing
  ) %>%
  summarize(
    num.missing = n()
  ) %>%
  filter(is.missing == TRUE) %>%
  select(-is.missing) %>%
  arrange(desc(num.missing))

missingValues

# Plot aus neuem Datensatz
missingValues %>%
  ggplot() +
  geom_bar(
    aes(
      variable, 
      num.missing
    ), 
    stat = 'identity'
  ) +
  labs(
    x = 'Variable',
    y = "Anzahl MV", 
    title = 'Missing Values pro Variable'
  ) +
  theme(
    axis.text.x = element_text(
      angle = 45, 
      hjust = 1
    )
  )

missingValues

# Missing Values in Prozenten
missingValues <-  pss %>%
  select(
    c(
      "idno", 
      "stfdem",
      "stfeco", 
      "trstprl", 
      "trstlgl"
    )
  ) %>% 
  pivot_longer(
    everything(),
    names_to = "key",
    values_to = "val"
  ) %>%
  mutate(isna = is.na(val)) %>%
  group_by(key) %>%
  mutate(total = n()) %>%
  group_by(
    key, 
    total,
    isna
  ) %>%
  summarise(num.isna = n()) %>%
  mutate(pct = num.isna / total * 100)

levels <- (
  missingValues  %>% 
    filter(isna == T) %>%     
    arrange(desc(pct))
)$key

missingsPercent <- missingValues %>%
  ggplot() +
  geom_bar(
    aes(
      x = reorder(
        key, 
        desc(pct)
      ), 
      y = pct, 
      fill = isna
    ), 
    stat = 'identity',
    alpha = 0.8) +
  scale_x_discrete(limits = levels) +
  scale_fill_manual(
    name = "", 
    values = c(
      'steelblue', 
      'tomato3'
    ), 
    labels = c(
      "vorhanden",
      "fehlend"
    )
  ) +
  coord_flip() +
  labs(
    title = "Prozent von missing values", 
    x = 'Variable', 
    y = "% missing values"
  )

missingsPercent

# Missings: Welcher Fall bei welcher Variable
rawPlot <-  pss %>%
  select(
    c(
      "idno", 
      "stfdem",
      "stfeco", 
      "trstprl", 
      "trstlgl"
    )
  ) %>% 
  pivot_longer(
    -c("idno"),
    names_to = "key",
    values_to = "val"
  ) %>%
  mutate(isna = is.na(val)) %>%
  ggplot(
    aes(
      key, 
      idno, 
      fill = isna)
  ) +
  geom_raster(alpha = 0.8) +
  scale_fill_manual(
    name = "",
    values = c(
      "steelblue", 
      "tomato3"
    ),
    labels = c(
      "vorhanden",
      "fehlend"
    )
  ) +
  scale_x_discrete(limits = levels) +
  labs(
    x = "Variable",
    y = "Row Number",
    title = "Missing values in rows"
  ) +
  coord_flip()

rawPlot

# > `naniar` & `UpSetR` ----

# absolute und relative Häufigkeiten von Missings
pss %>%
  miss_var_summary()

# gruppieren
pss %>% 
  group_by(district) %>% 
  miss_var_summary()

# kumulierte Summe von Missings pro Variable
gg_miss_var_cumsum(pss)

# Visualisierung von Missings des gesamten Datensatzes
vis_miss(pss)

# Häufigkeiten der Kombination der Missings zwischen den Variablen
plot3 <- ggplot(
  pss,
  aes(
    x = district,
    y = agea
  )
) +
  geom_miss_point() 

plot3

# Alternative 
plot4 <- gg_miss_var(
  pss,
  facet = district
)

plot4

# visuelle Aufbereitung von Missings 
plot5 <- gg_miss_fct(
  x = pss, 
  fct = district
)

gg_miss_fct(
  x = pss, 
  fct = district
) + 
  labs(title = "NA in PSS nach Distrikt")

plot5
