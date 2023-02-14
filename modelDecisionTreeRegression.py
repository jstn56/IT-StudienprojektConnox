#Import the Python Libraries
import pandas as pd
import numpy as np
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
import joblib
import tkinter as tk

# Läd die Daten für das Modell (Read the Dataset)
data = pd.read_csv("datenTRAINING.csv")

#Gegebenenfalls Anpassung der daten -> Datentypen, Nullwerte etc. (Explore the Dataset)

# Erstellt X- und y-Arrays für das Modell (Feature Selection) und für die Testdaten
X = data[["menge", "gewicht", "tag", "warengruppe"]]
y = data["dauer"]
train_data, test_data, train_target, test_target = train_test_split(X, y, test_size=0.2)

#Verwendung der Entscheidungsbaum-Regression
regressor = DecisionTreeRegressor()

#Trainieren das Model mit den TrainingsDaten
regressor.fit(train_data, train_target)

#Methode für UI Parameterübergabe und anschließende Berechnung + Ausgabe
def on_submit():
    menge = menge_entry.get()
    gewicht = float(gewicht_entry.get())
    tag = tag_entry.get()
    warengruppe = warengruppe_entry.get()
    prediction = regressor.predict([[menge, gewicht, tag, warengruppe]])
    result_label.config(text=f"Die Vorhersage für die übergebenen Parameter ist: {int(prediction[0])} Sekunden")
    if(prediction <= 30):
        class_label.config(text=f"Ordne die Retoure der Klasse 1 zu.")
    elif(prediction <= 60):
        class_label.config(text=f"Ordne die Retoure der Klasse 2 zu.")
    elif(prediction <= 90):
        class_label.config(text=f"Ordne die Retoure der Klasse 3 zu.")
    elif(prediction <= 140):
        class_label.config(text=f"Ordne die Retoure der Klasse 4 zu.")
    elif(prediction <= 200):
        class_label.config(text=f"Ordne die Retoure der Klasse 5 zu.")
    elif(prediction <= 360):
        class_label.config(text=f"Ordne die Retoure der Klasse 6 zu.")    
    else:
        class_label.config(text=f"Ordne die Retoure der Klasse 7 zu.")
    
root = tk.Tk()
root.title("Vorhersage der Bearbeitungszeit")

menge_label = tk.Label(root, text="Menge:")
menge_label.grid(row=0, column=0)
menge_entry = tk.Entry(root)
menge_entry.grid(row=0, column=1)

gewicht_label = tk.Label(root, text="Gewicht:")
gewicht_label.grid(row=1, column=0)
gewicht_entry = tk.Entry(root)
gewicht_entry.grid(row=1, column=1)

tag_label = tk.Label(root, text="Wochentag:")
tag_label.grid(row=2, column=0)
tag_entry = tk.Entry(root)
tag_entry.grid(row=2, column=1)

warengruppe_label = tk.Label(root, text="Warengruppe:")
warengruppe_label.grid(row=3, column=0)
warengruppe_entry = tk.Entry(root)
warengruppe_entry.grid(row=3, column=1)

submit_button = tk.Button(root, text="Berechnen", command=on_submit)
submit_button.grid(row=4, column=0, columnspan=2, pady=10)

result_label = tk.Label(root, text="Vorhersage:")
result_label.grid(row=5, column=0, columnspan=2)

class_label = tk.Label(root, text="Zuordnung in die Klasse:")
class_label.grid(row=6, column=0, columnspan=2)

root.mainloop()


y_pred = regressor.predict(X)
# Speichere die Vorhersagen in einer neuen CSV-Datei
prediction = pd.DataFrame({"bearbeitungszeit_vorhersage": y_pred, "dauer": y})
data["bearbeitungszeit_vorhersage"] = y_pred
prediction.to_csv("predictionTRAINING.csv", index=False)
data["Übereinstimmung"] = round((data["dauer"] / np.abs(data["bearbeitungszeit_vorhersage"]) -1) * 100, 2)
data.to_csv("predictionTRAINING.csv", index=False)
joblib.dump(regressor, "ConnoxPredictionModel.pkl")