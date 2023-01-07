###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Skript zu Lernblock 2                                                   #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Leon Klemm, B. Philipp Kleer                                   #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        #
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# 1. Datenerhebung & Datensätze ----

# > 1.1 Aufbau Datensatz ----

# >> Data frame ----
pss <- readRDS("./data/pss.rds")
pss

pagedPSS <- paged_table(
  pss[, c("idno", "agea", "gndr", "income", "stfdem")],
  options = list(rows.print = 15)
)
pagedPSS

# >> Data frame in R ----
strPSS <- str(pss)
strPSS

headPSS <- head(pss)
headPSS

tailPSS <- tail(pss)
tailPSS

stfdem

pss$stfdem


# > 1.2 Datenimport ----

# >> Text-Import ----

# Falls man Hilfe zur Funktion benötigt:
?read.table

exam <- read.table(
  "./data/exam.txt", 
  sep = "\t",                        
  header = TRUE
) 
exam



strExam <- str(exam)
strExam

headExam <- head(exam)
headExam

headExam10 <- head(
  exam,
  n = 10   # hier kann die Anzahl verändert werden
)
headExam10

headExamGrade <- head(exam$grade)
headExamGrade


# >> CSV-Import ----
examcsv <- read.csv(
  "./data/exam.csv", 
  header = TRUE
)
examcsv

examcsv2 <- read.csv2(
  "./data/exam.csv", 
  header = TRUE
)
examcsv2


# >> Lokales Arbeiten ----
path <- "C:/Dateipfad zum gespeicherten Objekt/" 
# kopiere dies aus dem Explorer oder Finder und denke daran bei Windows 
# die Backslashes zu Slashes zu ändern
path

exam <- read.table(
  file.path(
    path, 
    "exam.txt"
  ),
  sep = "\t",                        
  header = TRUE  
)  
exam


# >> R-Import ----
rm(
  exam, 
  examcsv, 
  examcsv2, 
  path
)

exam <- readRDS("./data/exam.rds")

# alternativ gesamter Workspace
load("./data/exam.RData")


# >> SPSS-Import ----
install.packages("foreign")
library("foreign")

examspss <- read.spss(
  "./data/exam.sav", 
  use.value.labels = FALSE,       
  to.data.frame = TRUE
)


# 2. Deskriptive Statistik ----

# > Allgemein ----
pss <- readRDS("./data/pss.rds")

headPSS <- head


strWkhtot <- str(pss$wkhtot)
strWkhtot

strGndr <- str(pss$gndr)
strGndr

strStfdem <- str(pss$stfdem)
strStfdem

strTrstprl <- str(pss$trstprl)
strTrstprl

lengthEdu <- length(pss$edu)
lengthEdu

dimPSS <- dim(pss)
dimPSS

# > Lagemasse ----

# Minimum
minWkhtot <- min(pss$wkhtot)
minWkhtot

# Maximum
maxWkhtot <- max(pss$wkhtot)
maxWkhtot

# Spannweite / Range 
rangeWkhtot <- range(pss$wkhtot)
rangeWkhtot

minStfdem <- min(
  pss$stfdem, 
  na.rm = TRUE
)
## na.rm: NA = missing values, rm = remove 
minStfdem

## Median
medianStfdem <- median(
  pss$stfdem, 
  na.rm = TRUE
) 
medianStfdem

## arithm. Mittelwert
meanStfdem <- mean(
  pss$stfdem, 
  na.rm = TRUE
)
meanStfdem

## Modus (no built-in function)
tabStfdem <- table(pss$stfdem)
tabStfdem

modeStfdem <- max(table(pss$stfdem)) 
# nicht hilfreich bei bimodalen (etc.) Verteilungen
modeStfdem


seq(
  from = 0,
  to = 1, 
  by = 0.1
)

seq(
  by = 0.1, 
  to = 1, 
  from = 0
) 

# wird die Standardreihenfolge (from-to-by) eingehalten, 
# kann man die Argumentbeschriftung auslassen.
seq(
  0, 
  1, 
  0.1
)

quantStfdem <- quantile(
  pss$stfdem, 
  probs = seq(
    0,
    1, 
    0.1
  ),    
  na.rm = TRUE
) 
quantStfdem

quintStfdem <- quantile(
  pss$stfdem, 
  probs = seq(
    0,
    1,
    0.2
  ),    
  na.rm = TRUE
)
quintStfdem

summaryStfdem <- summary(pss$stfdem)
summaryStfdem

# > Streumasse ----

iqrStfdem <- IQR(
  pss$stfdem, 
  na.rm = TRUE
)
iqrStfdem

AltIqrStfdem <- diff(
  quantile(
    pss$stfdem, 
    probs = c(
      0.25,
      0.75
    ),  
    na.rm = TRUE
  )
)
AltIqrStfdem


sdStfdem <- sd(
  pss$stfdem, 
  na.rm = TRUE
)
sdStfdem

varStfdem <-var(
  pss$stfdem, 
  na.rm = TRUE
)
varStfdem

AltVarStfdem <- sd(pss$stfdem, na.rm = TRUE) ^ 2
AltVarStfdem



# 3. Tidyverse ----

# > 3.1 dplyr ----

# >> Häufigste Funktionen ----
library("knitr")
library("htmltools")
library("tidyverse")
library("rmarkdown")

x <- c("select()", "slice()", "filter()", "arrange()", "mutate()", "summarize()", "group_by()")
x
y <- c("Spalte(n) wählen", "Zeile(n) wählen", "Zeile(n) filtern", "Zeile(n) ordnen", "neue Spalten / Variablen", "Werte zusammenfassen", "gruppieren")
y
data <- data.frame(x, y)
data
colnames(data) <- c("Funktion", "Operation")
rm(x, y)

pss <- readRDS("./data/pss.rds")
pss

kableData <- kable(data)
kableData

pagedPSS <- paged_table(
  pss,
  options = list(rows.print = 15)
)
pagedPSS

headPSS <- head(pss)
headPSS

# Select 
selectedPSS <- select(
  pss,
  c(
    gndr, 
    district
  )
)
selectedPSS

PagedSelectedPSS <- paged_table(
  select(
    pss, 
    c(
      gndr, 
      district
    )
  ),
  options = list(rows.print = 15)
)
PagedSelectedPSS

# Slice
slicedPSS <- slice(
  pss,
  50:55
)
slicedPSS

slicedPSS2 <- slice(
  pss, 
  seq(
    0, 
    1000,
    100
  )
)
slicedPSS2

# filter
filteredPSS <- filter(
  pss, 
  district == "Distrikt 1"
)
filteredPSS

PagedFilteredPSS <- paged_table(
  filter(
    pss,
    district == "Distrikt 1"
  ),
  options = list(rows.print = 15)
)
PagedFilteredPSS

filteredPSS2 <- filter(
  pss,
  district == "Distrikt 5" & gndr == "male"
)
filteredPSS2

PagedFilteredPSS2 <- paged_table(
  filter(
    pss,
    district == "Distrikt 5" & gndr == "male"
  ),
  options = list(rows.print = 15)
)
PagedFilteredPSS2

# arrange 
pssAsc <- arrange(
  pss, 
  wkhtot
)
pssAsc

headPssAsc <- head(pssAsc)
headPssAsc

pssDesc <- arrange(
  pss,
  desc(wkhtot)
)
pssDesc

headPssDesc <- head(pssDesc)
headPssDesc

# Alternativ Minuszeichen vor Variable
pssDesc2 <- arrange(
  pss, 
  -wkhtot
)
pssDesc2


# mutate 
mutatePSS <- mutate(
  pss, 
  wkhtotCen = wkhtot - mean(wkhtot, na.rm = TRUE)
)
mutatePSS

# mutate 2
mutatePSS2 <- paged_table(
  mutate(
    pss, 
    wkhtotCen = wkhtot - mean(wkhtot, na.rm = TRUE)
  ),
  options = list(rows.print = 15)
)
mutatePSS2

# mutate 3
mutatePSS3 <- mutate(
  pss,
  districtRec = case_when(
    district == "Distrikt 1" ~ 1, 
    district == "Distrikt 5" ~ 5, 
    district == "Distrikt 7" ~ 7,
    district == "Distrikt 10" ~ 10, 
    district == "Distrikt 12" ~ 12,
  )
)
mutatePSS3

PagedMutatePSS3 <- paged_table(
  mutate(
    pss,
    districtRec = case_when(
      district == "Distrikt 1" ~ 1, 
      district == "Distrikt 5" ~ 5, 
      district == "Distrikt 7" ~ 7,
      district == "Distrikt 10" ~ 10, 
      district == "Distrikt 12" ~ 12,
    )
  ),
  options = list(rows.print = 15)
)
PagedMutatePSS3

# mutate 4
mutatePSS4 <- mutate(
  pss, 
  d12gndr = case_when(
    district == "Distrikt 12" & gndr == "female" ~ 1
  )
)
mutatePSS4

PagedMutatePSS4 <- paged_table(
  mutate(
    pss, 
    d12gndr = case_when(
      district == "Distrikt 12" & gndr == "female" ~ 1
    )
  ),
  options = list(rows.print = 15)
)
PagedMutatePSS4

# mutate 5
mutatePSS5 <- mutate(
  pss, 
  d12gndr = case_when(
    district == "Distrikt 12" & gndr == "female" ~ 1,
    TRUE ~ 0
  )
)
mutatePSS5

PagedMutatePSS5 <- paged_table(
  mutate(
    pss, 
    d12gndr = case_when(
      district == "Distrikt 12" & gndr == "female" ~ 1,
      TRUE ~ 0
    )
  ),
  options = list(rows.print = 15)
)
PagedMutatePSS5

# summarize
summarizedPSS <- summarize(
  pss, 
  mean(wkhtot)
)
summarizedPSS

# group_by
groupedPSS <- group_by(
  pss,
  gndr
)
groupedPSS

groupedPSS2 <- summarize(
  group_by(
    pss, 
    gndr
  ), 
  mean(wkhtot)
)
groupedPSS2

# >> Piping ----
pss <- readRDS("./data/pss.rds")
pss

pss <- pss %>%
  group_by(district) %>%
  mutate(wkhtotMean = mean(
    wkhtot, 
    na.rm = TRUE
  )
  ) %>%
  ungroup() 
pss

# Berechnen/Rekodieren
pss <- pss %>%
  mutate(
    trstpltG = case_when(
      trstplt <= 3 ~ "low", 
      trstplt > 3 & trstplt <= 6 ~ "medium", 
      trstplt > 6 ~ "high"
    )
  )
pss

tabTrstpltG <- table(pss$trstpltG)
tabTrstpltG

strTrstpltG <- str(pss$trstpltG)
strTrstpltG

pss <- pss %>%
  mutate(
    trstpltG = case_when(
      trstplt <= 3 ~ "low", 
      trstplt > 3 & trstplt <= 6 ~ "medium", 
      trstplt > 6 ~ "high"
    )
  ) %>% 
  mutate(trstpltG = factor(trstpltG) #Schritt um von Character auf Factor zu kommen!
  )
pss

tabTrstpltG <- table(pss$trstpltG)
tabTrstpltG

strTrstpltG <- str(pss$trstpltG)
strTrstpltG

pss <- pss %>%
  mutate(
    trstpltG = case_when(
      trstplt <= 3 ~ "low", 
      trstplt > 3 & trstplt <= 6 ~ "medium", 
      trstplt > 6 ~ "high"
    )
  ) %>% 
  mutate(
    trstpltG = factor(
      trstpltG,
      ordered = TRUE, 
      levels = c(
        "low", 
        "medium", 
        "high"
      )
    ) 
  )
pss

tabTrstpltG <- table(pss$trstpltG)
tabTrstpltG

strTrstpltG <- str(pss$trstpltG)
strTrstpltG



pss <- pss %>%
  group_by(district) %>%
  mutate(
    wkhtotMean = mean(
      wkhtot, 
      na.rm = TRUE
    ),
    wkhtotDist = wkhtot - wkhtotMean  # wir fügen einfach diese einfache Berechnung des Abstands hinzu
  ) %>%
  ungroup()
pss

PipeHeadPSS <- head(
  pss[, 
      c(
        "district", 
        "wkhtot",
        "wkhtotMean",
        "wkhtotDist"
      )
  ]
)
PipeHeadPSS


meansDistriktEdu <- pss %>%
  group_by(
    district,
    edu
  ) %>%
  summarize(mean(wkhtot)) 

meansDistriktEdu


# >> Teilen eines Datensatzes ----
pssD1D12o30 <- pss %>%
  filter((district == "Distrikt 1" | district == "Distrikt 12") & wkhtot > 30)
pssD1D12o30

HeadPssD1D12o30 <- head(pssD1D12o30)
HeadPssD1D12o30


# >> Datensätze zusammenführen (Fälle hinzufügen) ----
pss <- readRDS("./data/pss.rds")
pss1 <- readRDS("./data/pss1.rds")
pss5 <- readRDS("./data/pss5.rds")
pss7 <- readRDS("./data/pss7.rds")
pss10 <- readRDS("./data/pss10.rds")
pss12 <- readRDS("./data/pss12.rds")

pssAll <- pss1 %>%
  bind_rows(
    list(
      pss5,
      pss7, 
      pss10, 
      pss12
    ), 
    .id = "origin"
  ) %>%
  mutate(
    origin = factor(
      origin, 
      labels = c(
        "process1", 
        "process2", 
        "process3", 
        "process4",
        "process5"
      )
    )
  )
pssAll

tabAllOrigrin <- table(pssAll$origin)
tabAllOrigrin

headAllOrigin <- head(pssAll$origin)
headAllOrigin


pssA <- pss[1:3, 2:3]
pssA

District <- c(
  "Distrikt 1", 
  "Distrikt 5",
  "Distrikt 7"
)
District

gndr <- c(
  "male",
  "female",
  "female"
)
gndr

pssB <- data.frame(
  District, 
  gndr
)
pssB

headPssA <- head(pssA)
headPssA

headPssB <- head(pssB)
headPssB

pssTest <- pssA %>% 
  bind_rows(pssB)

pssTest

# Unterschiedliche Spaltennamen
pssTest2 <- pssA %>% 
  full_join(pssB,
            by = c("district" = "District", 
                   "gndr" = "gndr"
            )
  )
pssTest2

headTest2 <- head(pssTest2)
headTest2

# >> 2 Datensätze kombinieren ----
pss <- readRDS("./data/pss.rds")
pssMacro <- readRDS("./data/pssMacro.rds")

kableMacro <- kable(pssMacro,
      caption =  "Makrodaten pro Distrikt"
)
kableMacro

pssMerged <- pss %>%
  left_join(
    pssMacro, 
    by = "district"
  )
pssMerged

PagedMerged <- paged_table(
  pssMerged,
  options = list(
    rows.print = 15,
    cols.print = 16
  )
)
PagedMerged

pssMerged2 <- pssMacro %>%
  right_join(
    pss, 
    by = "district"
  )
pssMerged2

PagedMerged2 <- paged_table(
  pssMerged2,
  options = list(
    rows.print = 15,
    cols.print = 16
  )
)
PagedMerged2

# >> Datensätze zusammenführen (neue Variablen) ----
pss <- readRDS("./data/pss.rds")
sp <- readRDS("./data/sp.rds")

headSP <- head(sp)
headSP

headPSS <- head(pss)
headPSS

sp <- sp %>% 
  rename(idno = id)
sp

headSP <- head(sp)
headSP

pss <- pss %>% 
  full_join(
    sp, 
    by = "idno"
  )
pss

headPSS <- head(pss)
headPSS

# > 3.2 tidyr ----

# >> Untidy Datensätze ----
statclass <- readRDS("./data/statclass.rds")
statclass2 <- readRDS("./data/statclass2.rds")

statclass
statclass2

# >> Tidy up Statclass ----
statclass

statclassTidy <- statclass %>% 
  pivot_longer(
    stat1:spss, 
    names_to = "course", 
    values_to = "grade"
  ) %>% 
  arrange(
    name,
    course
  )

statclassTidy

statclassRe <- statclassTidy %>% 
  pivot_wider(
    names_from = course, 
    values_from = grade, 
  )

statclassRe

# >> Tidy up Statclass 2 ----
statclass2

statclass2Tidy <- statclass2 %>%
  pivot_longer(
    momo:sascha, 
    names_to = "names", 
    values_to = "grade"
  )

statclass2Tidy

statclass2Tidy <- statclass2Tidy %>% 
  pivot_wider(
    names_from = exam, 
    values_from = grade
  ) %>% 
  relocate(names) %>% 
  arrange(
    names,
    test
  )

statclass2Tidy

statclass2re <- statclass2Tidy %>% 
  pivot_wider(
    names_from = test,
    values_from = c(
      exam1, 
      exam2
    )
  )
statclass2re

# 4. Programmierexkurs ----

# > If-Bedingung ----
mot <- 9

if (mot >= 7) {
  print("sehr motiviert")
}

# else if
mot <- 5

if (mot >= 7) {
  print("sehr motiviert")
} else if (mot >= 4 & mot < 7) {
  print("motiviert")
}


mot <- 3

if (mot >= 7) {
  print("sehr motiviert")
} else if (mot >= 4 & mot < 7) {
  print("motiviert")
} else if (mot >= 0 & mot < 4) {
  print("nicht motiviert")
}


# else
mot <- 5

if (mot >= 7) {
  print("sehr motiviert")
} else {
  print("nicht motiviert")
}

# > For-loop ----

for (i in 0:5) {
  print(i)
}


# Beispiel Zielwert
n <- 5

for (i in 0:n) {
  print(i)
}

# Beispiel Startwert
start <- 3

for (i in start:n) {
  print(i)
}


# Beispiel for-loop
teacher <- c("Baecker", 
             "Mueller",
             "Kaufmann",
             "Bauer",
             "Schuster"
)

for (i in 1:length(teacher)) {
  print(paste0("Dozent:in ", 
               i, 
               " ist ",
               teacher[i]
  )
  )
}

# for-loop mit else-if-Ausdruck 

for (i in 1:length(statistics$mot)) {
  if (statistics$mot[i] >= 7) {
    motivation <- "sehr motiviert"
    statistics$motText[i] <-  motivation
  } else if (statistics$mot[i] >= 4 & statistics$mot[i] < 7) {
    motivation <- "motiviert"
    statistics$motText[i] <-  motivation
  } else if (statistics$mot[i] >= 0 & statistics$mot[i] < 4) {
    motivation <- "nicht motiviert"
    statistics$motText[i] <-  motivation
  }
  
  print(paste0("Student:in ", 
               i, 
               " ist ",
               motivation
  )
  )
}

# for-loop mit next

table(statistics$grade2, 
      useNA = "ifany"
)

for (i in 1:length(statistics$grade2)) {
  if (is.na(statistics$grade2[i])) {
    statistics$g2text[i] <- NA
    next
  } 
  
  if (statistics$grade2[i] >= 13) {
    statistics$g2text[i] <- "sehr gut"
  } else if (statistics$grade2[i] >= 10 & statistics$grade2[i] < 13) {
    statistics$g2text[i] <- "gut"
  } else if (statistics$grade2[i] >= 7 & statistics$grade2[i] < 10) {
    statistics$g2text[i] <- "befriedigend"
  } else if (statistics$grade2[i] >= 5 & statistics$grade2[i] < 7) {
    statistics$g2text[i] <- "ausreichend"
  } else {
    statistics$g2text[i] <- "nicht bestanden"
  }
}

table(statistics$g2text)

# > Funktionen ----

my_function <- function(arg1, arg2, ..., argn){
  # Anweisungen
}
my_function


own_mean <- function(x){
  mean = sum(x) / length(x)
  
  print(mean) 
}

own_mean(statistics$grade)

# Eigene Funktion: IQR

own_iqr <- function(x){
  uGrenze <-  quantile(x,
                       probs = 0.25,
                       na.rm = TRUE
  )
  
  oGrenze <- quantile(x,
                      probs = 0.75,
                      na.rm = TRUE
  )
  
  abstand <- oGrenze - uGrenze
  
  print(paste("Das untere Quartil liegt bei:",
              uGrenze
  )
  )
  
  print(paste("Das obere Quartil liegt bei:",
              oGrenze
  )
  )
  
  print(paste("Der Interquartilsabstand beträgt:",
              abstand
  )
  )
}

own_iqr(statistics$grade)


own_iqr_return <- function(x){
  uGrenze <-  quantile(x,
                       probs = 0.25,
                       na.rm = TRUE
  )
  
  oGrenze <- quantile(x,
                      probs = 0.75,
                      na.rm = TRUE
  )
  
  abstand <- oGrenze - uGrenze
  
  print(paste("Das untere Quartil liegt bei:",
              uGrenze
  )
  )
  
  print(paste("Das obere Quartil liegt bei:",
              oGrenze
  )
  )
  
  print(paste("Der Interquartilsabstand beträgt:",
              abstand
  )
  )
  
  results <- list()
  
  results$uGrenze <- uGrenze[[1]]
  
  results$oGrenze <-oGrenze[[1]]
  
  results$abstand <- abstand[[1]]
  
  return(results) 
}

test <- own_iqr(statistics$grade)

test

# Funktionen und Schleifen

showcase <- function(x){
  for (i in 1:length(x)) {
    if (is.na(x[i])) {
      print(paste("Für Student", 
                  i, 
                  "liegt kein Wert vor."
      )
      )
      next
    } else {
      abstand = mean(x, 
                     na.rm = TRUE
      ) - x[i]
      
      print(paste0("Student ",
                   i, 
                   " hat folgenden Wert: ",
                   x[i], 
                   " (Abweichung zum Mean: ",
                   round(abstand, 
                         2
                   ),
                   ")"
      )
      )
    }
  }
}

showcaseGrade <- showcase(statistics$grade)
showcaseGrade

showcaseGrade2 <- showcase(statistics$grade2)
showcaseGrade2