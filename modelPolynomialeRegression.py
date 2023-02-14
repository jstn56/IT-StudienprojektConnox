#Import the Python Libraries
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score, median_absolute_error
from sklearn.model_selection import train_test_split
import tkinter as tk

# Ladet die tagn für das Modell (Read the Dataset)
data = pd.read_csv("datenv5retouren.csv")

#Gegebenenfalls Anpassung der tagn -> datentypen, Nullwerte etc. (Explore the Dataset)

# Erstellt X- und y-Arrays für das Modell (Feature Selection)
X = data[["menge", "gewicht", "tag", "warengruppe"]]
y = data["dauer"]

# Erstellt das Modell und passt es an die daten an (Build the Model) 0,2 -> 20% der daten als Testmenge
train_data, test_data, train_target, test_target=train_test_split(X,y,test_size=0.2)

# Polynomiale Features erstellen
poly = PolynomialFeatures(degree = 4)
train_poly = poly.fit_transform(train_data)

#Initialisierung der LinearRegression
model = LinearRegression()
#Trainieren das Model mit den Trainingsdaten
model.fit(train_poly, train_target)

# Vorhersagen für Testdaten machen
testdata_poly = poly.transform(test_data)
y_pred = model.predict(testdata_poly)

#Methode für UI Eingabe und anschließende Ausgabe
def on_submit():
    menge = menge_entry.get()
    gewicht = float(gewicht_entry.get())
    tag = tag_entry.get()
    warengruppe = warengruppe_entry.get()
    new_input = [[menge, gewicht, tag, warengruppe]]
    new_input_poly = poly.transform(new_input)
    prediction = model.predict(new_input_poly)

    result_label.config(text=f"Die Vorhersage für die übergebenen Parameter ist: {int(prediction[0])} Sekunden")
    if(prediction <= 15):
        class_label.config(text=f"Ordne die Retoure der Klasse Sehr Schnell zu.")
    elif(prediction <= 30):
        class_label.config(text=f"Ordne die Retoure der Klasse Schnell zu.")
    elif(prediction <= 60):
        class_label.config(text=f"Ordne die Retoure der Klasse Mittel zu.")
    elif(prediction <= 120):
        class_label.config(text=f"Ordne die Retoure der Klasse Langsam zu.")
    else:
        class_label.config(text=f"Ordne die Retoure der Klasse Sehr Langsam zu.")
    
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