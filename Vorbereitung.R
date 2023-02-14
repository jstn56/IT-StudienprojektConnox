library(corrplot)
library(ggplot2)
library(ggpubr)

# Einlesen der Daten
daten <- read.csv("datenv5_ohne_ausreisser.csv")

# Anzahl der Zeilen und Spalten des Datensatz anzeigen
dim(daten)

# Mittelwerte und Standardabweichungen bestimmen
mean(daten$gewicht)
mean(daten$dauer)
mean(daten$menge)
mean(daten$grund)
mean(daten$warengruppe)
mean(daten$tag)
sd(daten$gewicht)
sd(daten$dauer)
sd(daten$menge)
sd(daten$grund)
sd(daten$warengruppe)
sd(daten$tag)

# Ausreisser entfernen mit der Z-Scores Methode
z_scores <- as.data.frame(sapply(daten, function(daten)
  abs(daten-mean(daten))/sd(daten)))

# Entfernung aller Daten mit einem Absolutwert groesser 3 
c.data <- daten[!rowSums(z_scores>3),]

# Anzahl der Zeilen und Spalten des neuen Datensatz anzeigen
dim(c.data)

barplot(table(c.data$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge")

# Ergebnis: x Ausreisser gefunden und entfernt

# Pruefen der Korrelationen nach Entfernung der Ausreisser 
# korrelationen mit sich selbst entfernen
N <- cor(c.data)
corrplot(N, method="circle", type="lower", tl.col="black") # Darstellung mit Punkten
corrplot(N, method="number", type="lower", tl.col="black") # Darstellung mit Zahlen
corrplot(N, method = 'circle', type = 'lower', insig='blank', tl.col="black",
         addCoef.col ='black', number.cex = 0.8, order = 'AOE', diag=FALSE) # gemischt Darstellung ohne 1
corrplot(N, method = 'circle', type = 'lower', insig='blank', tl.col="black", 
         addCoef.col ='black', number.cex = 0.8, order = 'AOE') # gemischt Darstellung mit 1

# Tabelle anpassen
data <- c.data[,-(7:12)]
pairs(data, pch = 18, col = "steelblue")

#Installieren und laden Sie die GGally- Bibliothek
install.packages("GGally")
library(GGally)

#Generieren Sie das Paardiagramm
ggpairs(data)

#z-Standardisierung der restlichen Variablen 
c.data$zgewicht <- scale(c.data$gewicht) 
c.data$zdauer <- scale(c.data$dauer)
c.data$zmenge <- scale(c.data$menge)
c.data$zgrund <- scale(c.data$grund)
c.data$zwarengruppe <- scale(c.data$warengruppe)
c.data$ztag <- scale(c.data$tag)

# Tabelle anpassen
c.data.z <- c.data[,-(1:6)]

# Mittelwerte und Standardabweichungen vom standardisierten Datensatz bestimmen
mean(c.data.z$zgewicht)
mean(c.data.z$zdauer)
mean(c.data.z$zmenge)
mean(c.data.z$zgrund)
mean(c.data.z$zwarengruppe)
mean(c.data.z$ztag)
sd(c.data.z$zgewicht)
sd(c.data.z$zdauer)
sd(c.data.z$zmenge)
sd(c.data.z$zgrund)
sd(c.data.z$zgewicht)
sd(c.data.z$zwarengruppe)
sd(c.data.z$ztag)

