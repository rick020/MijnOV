# design

<p><img src=doc/uml.png>

__Google Maps Directions API__

Met deze api kan ik een route laten berekenen voor een startpunt naar een opgegeven eindpunt. Het start en eindpunt wordt opgegeven dmv van coordinaten(latitude/longitude). Uit de api ga ik de volgende variabele gebruiken:
* place_id
* arrival_time
* departure_time
* start_address
* end_address

Het start en eindadres worden opgeslagen in Preference Database. De huidige vertrektijd wordt tussen deze twee punten wordt nu op het beginscherm getoond. 

__Input Controller__

De Input Controller haalt de locatie op via de CLLocationManager(). Dit is een class in Swift die de huidige locatie kan bepalen. Aan de hand van de locatie en het opgegeven eindpunt van de gebruiker kan een route berekent worden.

__Check Neighbourhood__

Deze controller kijkt naar de huidige locatie van de gebruiker. Wanneer de afstand tussen de huidige locatie en de locatie de opslagen startadressen minder is dan X meter krijgt de gebruiker een Push bericht met de actuele vertrektijd vanaf de dichtstbijzijnde naar de opgeslagen bestemmingen. De afstand van de gebruiker naar het startadres wordt berekent door de Google Distance Matrix Api.

__Concept Design__
__https://xd.adobe.com/view/abd482b5-f78d-4c68-8471-adb29e8bcf0e/__

<p><img src=doc/iPhone1.png><img src=doc/iPhone2.png><img src=doc/iPhone3.png><img src=doc/iPhone4.png>