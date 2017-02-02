d# Dag 9/1

Voorstel met wireframes in README gezet.

# Dag 10/1

Layout ontworpen en de verdeling van de classe gemaakt in een UML

# Dag 11/1

Meeting het de groep en onze ideeën besproken.
Gelukt om coordinaten op te halen aan de hand van de huidige locatie.

# Dag 12/1

Coordinaten kunnen nu omgezet worden naar een adres.
Http request maken naar de Google Directions API.

# Dag 13/1

Afgemeld(ziek)

# Dag 16/1

Route plannen en weergeven

# Dag 17/1

Route opslaan met Core Date en weergeven in tabel.

# Dag 18/1

* Kleuren en icoontjes aan de layout toegevoegd.
* Reizen kunnen verwijdert worden uit de tabel.
* Actuele reisdata wordt in de tabel weergeven.
* Meerdere reizen in tabel zorgen voor bugs. Helaas heb ik dit niet kunnen fixen, omdat er geen begeleiding was.
<p><img src=doc/homescreen.PNG width=20%><img src=doc/search_view.PNG width=20%><img src=doc/routes_view.PNG width=20%>

# Dag 19/1

* Vandaag aan de slag gegaan met deze tutorial: https://www.raywenderlich.com/136165/core-location-geofencing-tutorial.
* In mijn app wil ik ook een Geofence gaan gebruiken. Wanneer een gebruiker in de buurt komt van een halte krijgt hij/zij een push bericht van de vertrektijden van die halte naar zijn voorgeplande reis.
* Het implementeren van een geofence is moeilijker dan gedacht, dus hier gaat nog veel tijd in zitten.

# Dag 23/1

* Code opgedeeld volgens het MVC model. Hierdoor heb ik bugs kunnen verhelpen. Het is nu mogelijk om meerdere reizen in de tabel op te slaan. Deze laten hun eigen reisadvies zien.

# Dag 24/1

* Vandaag heb ik het voor elkaar gekregen om een werkend Geofence te maken. Echter werkt deze nog niet op de achtergrond. 

# Dag 25/1

* Vandaag tot de conclusie gekomen dat ik het geofence niet meer volledig kan implementeren. Dit houdt in dat de app geen notificatie kan geven wanneer de app op de achtergrond runt. De reden waarom dit niet meer gaat lukken is dat ik de hele code zou moeten herschrijven om het te laten werken. De structuur zou helemaal aangepast moeten worden. Daardoor heb ik besloten om nog kleine features toe te voegen. Ik ben nu bezig de Auto Complete API van Google. Deze wordt geïmplementeerd in zoekscherm.

# Dag 26/1
* Het is gelukt om de Auto Complete te implementeren.

# Dag 30/1
* Die dag had ik een sollicitatiegesprek.

# Dag 31/1
* Overbodig code weggeschreven. Daarnaast ben ik er achter gekomen dat het laden van de huidige locatie erg lang duurt. Het gaat "fout" na het initialiseren van het object. Het duurt ongeveer 8 seconde wanneer de functie binnen het object wordt aangeroepen. Morgen ga ik proberen dit op te lossen. Dit heeft mijn hoogste prioriteit aangezien de functie wel gewoon werkt. Het duurt gewoon iets langer.

# Dag 1/2
* Vandaag aan mijn report gewerkt en daarnaast is het mij ook gelukt om de bug van gisteren op te lossen. In de initializatie wordt nu een andere functie aangeroepen die de locatie ophaalt. 

# Dag 2/2
* License en Credits toegevoegd aan de README. Verder heb ik mijn Process Book en Report afgemaakt. Done!  
