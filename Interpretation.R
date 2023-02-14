library(dplyr)

# Visualisierung der Clusterzugehoerigkeit
Cluster <- factor(ergebnisk$clusterk)

k1 <- ggplot(ergebnisk, aes(x=gewicht, y=warengruppe)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k2 <- ggplot(ergebnisk, aes(x=gewicht, y=dauer)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k3 <- ggplot(ergebnisk, aes(x=gewicht, y=menge)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k4 <- ggplot(ergebnisk, aes(x=gewicht, y=grund)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k5 <- ggplot(ergebnisk, aes(x=gewicht, y=tag)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k6 <- ggplot(ergebnisk, aes(x=dauer, y=warengruppe)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k7 <- ggplot(ergebnisk, aes(x=dauer, y=tag)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k8 <- ggplot(ergebnisk, aes(x=dauer, y=menge)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k9 <- ggplot(ergebnisk, aes(x=dauer, y=grund)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k10 <- ggplot(ergebnisk, aes(x=menge, y=dauer)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k11 <- ggplot(ergebnisk, aes(x=grund, y=warengruppe)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k12 <- ggplot(ergebnisk, aes(x=grund, y=tag)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k13 <- ggplot(ergebnisk, aes(x=menge, y=warengruppe)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k14 <- ggplot(ergebnisk, aes(x=menge, y=tag)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()
k15 <- ggplot(ergebnisk, aes(x=warengruppe, y=tag)) + 
  geom_point(aes(colour=Cluster)) +
  scale_color_brewer(type = "qual", palette = 7) +
  theme_pubr()

Clusterzugehoerigkeitk <- ggarrange(k1, k2, k3, k4, k5, k6, k8, k9, k10, k11,
                                    k12, k13, k14, k15,
                                    common.legend = TRUE,
                                    ncol = 4, nrow = 4)
Clusterzugehoerigkeitk

M_k <- c.data %>%
  group_by(clusterk) %>%
  summarise(gewicht = mean(gewicht), 
            dauer = mean(dauer),
            menge = mean(menge),
            grund = mean(grund),
            warengruppe = mean(warengruppe),
            tag = mean(tag))

# Mittelwerte auf Konsole anzeigen lassen
round(M_k)

library(ggpubr)
# Boxplots
par(mfrow=c(3,2))

boxplot(c.data$gewicht~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Gewicht", 
        border=(c("darkgrey", "purple", "darkblue", "pink", "lightgreen",
                  "orange")),
        col=(c("white","white")))
boxplot(c.data$dauer~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Dauer", border=(c("darkgrey", "purple", "darkblue",
                                "pink", "lightgreen", "orange")),
        col=(c("white","white")))
boxplot(c.data$menge~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Menge", 
        border=(c("darkgrey", "purple", "darkblue","pink", "lightgreen", 
                  "orange")),
        col=(c("white","white")))
boxplot(c.data$grund~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Retourengrund", 
        border=(c("darkgrey", "purple", "darkblue", "pink", "lightgreen",
                  "orange")),
        col=(c("white","white")))
boxplot(c.data$warengruppe~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Warengruppe", 
        border=(c("darkgrey", "purple", "darkblue", "pink", "lightgreen",
                  "orange")),
        col=(c("white","white")))
boxplot(c.data$tag~c.data$clusterk, xlab="Cluster", ylab = "",
        main="Tag", 
        border=(c("darkgrey", "purple", "darkblue", "pink", "lightgreen",
                  "orange")),
        col=(c("white","white")))

# Mittelwerte der Variablen in den vers. Clustern als Diagramm
a <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$gewicht), group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Gewicht in g")+
  ggtitle("Gewicht")

b <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$warengruppe), 
                            group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Warengruppe")+
  ggtitle("Warengruppe")

c <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$dauer), group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Dauer in s")+
  ggtitle("Dauer")

d <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$menge), group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Menge (absolut)")+
  ggtitle("Menge")

e <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$grund), 
                            group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Grund")+
  ggtitle("Retourengrund")

f <- ggplot(data = M_k, aes(x=clusterk, y=stat(M_k$tag), 
                            group=clusterk))+
  geom_bar(aes(fill=clusterk))+
  theme(legend.position = "none")+ # Legende entfernen
  xlab("Cluster")+
  ylab("Wochentag")+
  ggtitle("Wochentag")


# zusammenfassen 
Vergleich <- ggarrange(a, b, c, d, e, f,
                       ncol = 2, nrow = 3)
Vergleich

# Cluster einzeln betrachten für paar Sachen
c1 <- subset(ergebnisk, clusterk == 1)
c2 <- subset(ergebnisk, clusterk == 2)
c3 <- subset(ergebnisk, clusterk == 3)
c4 <- subset(ergebnisk, clusterk == 4)
c5 <- subset(ergebnisk, clusterk == 5)
c6 <- subset(ergebnisk, clusterk == 6)
c7 <- subset(ergebnisk, clusterk == 7)
c8 <- subset(ergebnisk, clusterk == 8)

par(mfrow=c(3,3))
barplot(table(c1$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 1", col = "lightgreen")
barplot(table(c2$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 2", col = "lightblue")
barplot(table(c3$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 3", col = "red")
barplot(table(c4$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 4", col = "purple")
barplot(table(c5$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 5", col = "orange")
barplot(table(c6$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 6", col = "yellow")
barplot(table(c7$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 7", col = "lightpink")
barplot(table(c8$warengruppe), xlab = "Warengruppe", ylab = "Häufigkeit", 
        main = "Häufigkeit der Warengruppe in Cluster 8", col = "darkgreen")

par(mfrow=c(3,3))
barplot(table(c1$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 1", col = "lightgreen")
barplot(table(c2$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 2", col = "lightblue")
barplot(table(c3$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 3", col = "red")
barplot(table(c4$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 4", col = "purple")
barplot(table(c5$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 5", col = "orange")
barplot(table(c6$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 6", col = "yellow")
barplot(table(c7$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 7", col = "lightpink")
barplot(table(c8$menge), xlab = "Menge", ylab = "Häufigkeit", 
        main = "Häufigkeit der Menge in Cluster 8", col = "darkgreen")

par(mfrow=c(3,3))
barplot(table(c1$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 1", col = "lightgreen")
barplot(table(c2$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 2", col = "lightblue")
barplot(table(c3$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grundsin Cluster 3", col = "red")
barplot(table(c4$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 4", col = "purple")
barplot(table(c5$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 5", col = "orange")
barplot(table(c6$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 6", col = "yellow")
barplot(table(c7$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 7", col = "lightpink")
barplot(table(c8$grund), xlab = "Grund", ylab = "Häufigkeit", 
        main = "Häufigkeit des Grunds in Cluster 8", col = "darkgreen")