###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
# Skript zum Lernblock 1                                                  #
# Kurs:    Statistik+: Einstieg in R leicht gemacht                       #
# Autor:   Meike Schulz-Narres, B. Philipp Kleer                          #
# Uni:     Justus-Liebig-University Giessen (Germany)                     #
# Term:    Sommer 2022                                                    #
# Lizenz:  CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) #                                                                        #
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

# Objekte in R erstellen ----
#Zunächst stellen wir eine einfache Rechnung an.
3 + 4 #Die Rechnung wird ausgeführt, das Ergebnis jedoch nicht gespeichert.

#um das Ergebnis zu speichern, müssen wir die Rechnung einem Objekt zuweisen.
math <- 3 + 4 #Zuweisungen macht man über Pfeile.
#Dir wird auffallen, dass das Objekt math jetzt im Environment auftaucht.

#Um dir das Ergebnis anzeigen zu lassen reicht es, schreibst du den Namen des
#Objekts in die nächste Zeile und führst diese aus.
math 
# Jetzt wird dir das Ergebnis in  der Console angezeigt.


# > Erste Rechnungen ----
#Führe eine Rechnung aus, die eine Multiplikation und eine Addition 
#beinhaltet und als Ergebnis 20 hat.
6 * 2 + 8 #Multiplizieren funktioniert mit *. Addition klassisch mit +. 

#Speichere eine weitere Rechnung im Objekt result, das nur aus einer
#Subtraktion besteht und als Ergebnis 17 hat.
result <- 30 - 13

# Wertetypen ----
# > Wertetyp: Numeric ----
#Speichern einer Kommazahl in einem Objekt.
mathNum <- 2.345 #WICHTIG! Kommazahlen mit Punkt trennen. Englische Schreibweise!
mathNum #ausführen um das Ergebnis anzeigen zu lassen.

# > Wertetyp Character ----
#WICHTIG! den Begriff in Anführungszeichen setzen.
hometown <- "Berlin" #Zuweisung des Begriffs Berlin zum Objekt hometown.
hometown #Ergebnis aufrufen

# > Wertetyp logical ----
#WICHTIG! TRUE und FALSE immer komplett groß schreiben.
truth <- TRUE #Erschaffen des Objekts truth mit dem Wert TRUE.
truth #Ergebnis aufrufen.

# Vektoren ----
#Erstellen eines Vektors math, der die Werte 0.2, 0.4, 0.6, 0.8 & 1.0 enthält.
math <- c( #Zeigt an, dass diese Zahlen zusammen im Objekt abgelegt werden.
  0.2, #die einzelnen Zahlen werden durch Kommata getrennt.
  0.4, 
  0.6, 
  0.8, 
  1.0
)     # der Befehl muss mit einer Klammer abgeschlossen werden.
#Wo Klammern geöffnet werden, muss es auch immer ein Gegenstück geben.

math #aufrufen des Vektors.

#Auch mit anderen Wertetypen können Vektoren geschaffen werden.

logi <- c( #Schaffen des Vektors logi. 
  TRUE, #beinhaltet diese mit Komma getrennten Werte.
  FALSE
)#Schließen des Befehls

numbers <- c( #schaffen des Vektors numbers
  1,  # beinhaltet diese duch Komma getrennten Zahlen.
  2, 
  3, 
  4, 
  5, 
  6, 
  7, 
  8, 
  9, 
  10
) #Schließen des Befehls.

char <- c(  #Schaffen des Vektors char.
  "Taipeh", #Beinhaltet mit "" gekennzeichnete & durch Komma getrennten Begriffe.
  "Seoul",  #Zur Erinnerung: "" sind nötig, damit R erkennt, dass
  "Berlin", #der Inhalt nicht verarbeitet werden muss.
  "Taipeh"
) # Schließen des Befehls.

# wir können die Wertetypen auch mischen.
mix <- c( #Erschaffen des Vektors mix.
  1.231, 
  "Berlin", #auch hier in ""
  TRUE
) #schließen des Befehls.

# > Objekte testen ----
is.numeric(numbers) #hier wird getestet, ob das Objekt numbers numerisch ist.
#Das Ergebnis: TRUE!

is.integer(math) #hier wird getestet ob math integer ist.
#Das Ergebnis: FALSE! Weil Kommazahlen enthalten sind.

is.logical(logi) #Hier wird getestet ob logi dem Wertetyp logical entspricht.
#Das Ergebnis: TRUE!

is.character(logi) #Hier wird getestet ob logi dem Wertetyp character entspricht.
#Ergebnis: FALSE! Weil die Werte zwar aus Buchstaben bestehen, aber die 
#Anführungszeichen fehlen. FALSE und TRUE haben in der Sprache R eine Bedeutung.

# > Einzelne Elemente innerhalb eines Vektors ----
char[3] #wir rufen hier den dritten Wert innerhalb unseres Vektors char auf.
#Person 3 hat also als Heimatstadt "Berlin" angegeben.

# Faktoren ----
# Faktoren beinhalten levels, die die Beschreibung der Werte beinhalten.
as.factor(char) #Wir lassen uns hier die Levels/Werte von char anzeigen.
#Den Vektor auszugeben bedeutet im Gegensatz zu den Levels also, dass der Vektor 
#alle Fälle anzeigt. Lassen wir den Faktor ausgeben, bekommen wir 
#alle Levels, nicht aber alle Fälle.

charFactor <- as.factor(char) # Auch dies speichern wir wieder in einem Objekt.

# > Werte im Faktor ordnen ----
#Wir haben eine Klasse von 6 Schüler:innen in den USA, die eine Klausur 
#geschrieben hat. Aus den Noten erstellen wir zunächst einen Vektor.
grade <- c( #mit dem combine Befehl ordnen wir 6 Werte dem Vektor grade zu.
  "A",      
  "C",
  "D",
  "B",
  "C", 
  "A"
) #Wir schließen den Befehl mit einer Klammer.

grade #Und lassen uns den Vektor ausgeben.


#um die Werte nun zu ordnen erschaffen wir den Vektor gradeOrd.
gradeOrd <- factor(
  grade,  # 1. Argument:Daten die geordnet werden sollen.
  ordered = TRUE,  # 2. Argument: Setze eine Ordnung.
  levels = c(    # 3. Argument: Angabe, wie geordnet werden soll.
    "D",  #Der erste Wert ist der letzte in der Ordnung.
    "C",
    "B",
    "A"
  ) #Schließen des combine-Befehls.
) #Schließen des factor-Befehls.

gradeOrd

# Dataframes ----

#Zunächst brauchen wir vier Vektoren. Diese spiegeln vier Fragen aus einer Umfrage
#und deren Antworten wider. Antwortmöglichkeiten von 1-5.

auswahl <- c(
  4, 
  1, 
  3, 
  2, 
  5
)   # Variable 1

geschmack <- c(
  2,
  5,
  2,
  1,
  1
) # Variable 2

service <- c(
  3,
  3,
  1,
  5,
  4
)    # Variable 3

ambiente <- c(
  1,
  2,
  4,
  4,
  3
)   # Variable 4

preis <- c(
  5,
  1,
  5,
  3,
  2
)     # Variable 5
#Diese fünf Variablen müssen jetzt zu einem Datensatz verbunden werden.
#df ist der Name des Objektes/Datensatzes.
df <- cbind( #das c vor bind steht für column(Spalte). Variablen werden 
  auswahl,   #traditionell in die Spalten gesetzt.
  geschmack, 
  service,
  ambiente, 
  preis
)

df #Datensatz ausgeben.

df2 <- data.frame(df) #wir müssen R noch sagen, dass es sich bei df um einen
#Dataframe handelt.

df2

#Wir können uns auch in Dataframes einzelne Werte und sogar ganze Zeilen
#oder Spalten ausgeben lassen. Die Funktion dafür kennst du schon.

df2[1, 1] #Hier wird aus df2 der Eintrag aus Zeile 1, Spalte 1 ausgegeben.

df2[3, ] # dritte Zeile

df2[,5] # fünfte Spalte

#mehrere Spalten gleichzeitig kannst du dir so ausgeben.
# Spalte 1, 3 & 4
df2[, 
    c(
      1,
      3, 
      4
    )
]

#Alternativ geht das auch mit einem Doppelpunkt.
df2[3:5, ] #hier werden Zeilen ausgegeben, da die Angabe vor dem Komma steht.

#Du musst aber nicht immer die Position wissen, sondern kannst 
#auch die Variablennamen verwenden.
# Spalte auswahl, service und preis
df2[,
    c(
      "auswahl", 
      "service", 
      "preis"
    )
]