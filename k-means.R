library("cluster")
library("factoextra")
library("magrittr")

# Distanzmatrix berechnen
#begruendung für euklidische distanz
d <- dist(c.data.z, method = "euclidean") 

# Clusteranzahl für k-means mit Silhouetten-Koeffizienten abschätzen
fviz_nbclust(c.data, kmeans, method = "silhouette")+ theme_classic()+
  labs(title = "Silhouette-Score", x="Clusteranzahl", 
     y="Durchschnittliche Silhouetten Breite")

# Clusteranzahl für k-means mit Elbow abschätzen
fviz_nbclust(scale(c.data[1:6]), kmeans, method = "wss")+
  labs(title = "Elbow-Kriterium", x="Clusteranzahl", 
       y="Fehlerquadratsumme")

# Knick bei x

#k-Means-Verfahren
clusterzentren <- kmeans(c.data.z, 
                          centers = 8, 
                          nstart = 200) 

#Ergebnisse des k-Means-Verfahren anzeigen
clusterzentren

# kmeans durchfuehren
km.noOutlier.res <- kmeans(scale(c.data[,1:6]), centers = 8, nstart = 200)
# Visualisieren mit Hilfe der PCA (erste zwei Hauptkomponenten)
fviz_cluster(km.noOutlier.res, # clusterergbnis uebergeben
             data = scale(c.data[,1:6]),  # Datenbasis uebergeben
             stand = TRUE,
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal(), 
             main = "")

# Clustergroessen, Mittelwerte anschauen 
# Streeuungsquadratsumme mit anderen vergleichen (gibt Abstaende zu Clusterzentren an) -> kleiner ist besser
# zum Datensatz hinzufuegen
clusterzentren$cluster
clusterzentren$centers
c.data$clusterk <- clusterzentren$cluster

# Tabelle anpassen, damit man es spaeter einfacher beim Visualisieren hat
ergebnisk <- c.data[,-(7:12)]



