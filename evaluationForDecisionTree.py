import pandas as pd
import numpy as np
import joblib
# Lade das trainierte Vorhersagemodell
model = joblib.load("ConnoxPredictionModel.pkl")
# Lese die neue CSV-Datei ein
data = pd.read_csv("datensatzEVA.csv")
# Trenne die Eingabe- und Ausgabewerte
X = data[["menge", "gewicht", "tag", "warengruppe"]]
y = data["dauer"]
# Nutze das Vorhersagemodell, um Vorhersagen zu treffen
y_pred = model.predict(X)
# Speichere die Vorhersagen in einer neuen CSV-Datei, zusätzlich zu der eingelesenen CSV-Datei
prediction = pd.DataFrame({"bearbeitungszeit_vorhersage": y_pred, "dauer": y})
data["bearbeitungszeit_vorhersage"] = y_pred
prediction.to_csv("predictionEVA.csv", index=False)
#Berechne die Übereinstimmung der Dauer der Bearbeitungszeit aus den Daten mit unserer Vorhersage
data["Übereinstimmung"] = abs(round((data["dauer"] / np.abs(data["bearbeitungszeit_vorhersage"]) -1) * 100, 2))
data.to_csv("predictionEVA.csv", index=False)
#Schreibe die durchschnittliche Übereinstimmung in die Konsole
mean_value = round(np.mean(data["Übereinstimmung"]), 0)
print("Die durchschnittliche Übereinstimmung der Bearbeitungsdauer und der Vorhersage: ", mean_value, "Sekunden")
