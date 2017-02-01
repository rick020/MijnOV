# Final Report
Studenten nemen dagelijks dezelfde route met het OV. Het is daarom onnodig om je eindbestemming telkens in te voeren in je reisplanner. In deze app kan vaak gebruikte routes opslaan. Wanneer de app wordt geopend worden deze routes automatisch gepland op basis van je huidige locatie. Hierdoor zie je gelijk wanneer jouw trein/tram/metro/bus vertrekt. Dit kan je doen voor meerdere routes. Wanneer je in de buurt van een voorkeurs station/halte komt krijg je een push bericht met de vertrektijden (wanneer de app geopend is).

## Technical Design

De applicatie bestaat uit drie viewcontrollers: 
* SavedDirectionsViewController
* SearchViewController
* RegionViewController

### SavedDirectionViewContoller

In deze viewcontroller staat de tabel die opgeslagen reizen weergeeft. De tabel bestaat uit een lijst met Directions objecten. Deze objecten bevatten reisdetails van de opgeslagen reizen. De objecten worden aangemaakt met behulp van de [Google Directions API](#google-directions-api) en [Core Location](#core-location) bij het uitlezen van [Core Data](#core-data). Het scherm kan herladen worden door de tabel naar bedenen te schuiven.

#### Google Directions API
Op basis van de opgegeven startlocatie, eindbestemming, manier van reizen en api key wordt een http verzoek verstuurd naar de Google Directions API. 

Voorbeeld request: *https://maps.googleapis.com/maps/api/directions/json?origin=1078NW+Amsterdam&destination=Amsterdam+Centraal&mode=transit&key=*

#### Core Location
Core location haalt de huidige locatie op van de gebruiker wanneer de app geladen wordt. Hiervoor moet de gebruiker eerst toestemming geven. Zonder deze toestemming kan de applicatie niet functioneren. 

#### Core Data
Core data is een systeem om data te organiseren binnen de applicatie. In deze applicatie wordt alleen de eindbestemming van de gebruiker opgeslagen in Core Data. Deze eindbestemming wordt opslagen in de vorm van een string.

### SearchViewController
De gebruiker kan met de SearchViewController een reis creëeren middels het zoekvenster. Een reis wordt gecreëerd wanneer er op een eindbestemming wordt geklikt.

#### Google Places API
Deze api zorgt voor een autocomplete bij het zoeken naar een eindbestemming. Bij het invoeren van tekens geeft deze api een locatie suggestie terug in een tabelvorm. Voor het implementeren van deze API moest je eerst drie Framework installeren: Google Maps, GooglePlacePicker en GooglePlaces. Dit heb ik met behulp van de applicatie Cocoa Pods gedaan.

#### Core Data
In deze viewcontroller wordt Core Data gebruikt om de eindbestemming op te slaan wanneer een reis wordt gecreëert door de gebruiker. 

### RegionViewController
Deze viewcontroller wordt geladen wanneer op een cel in de tabel geklikt wordt. Er wordt een object met alle reisdetails meegestuurd aan de hand van een segue. Op basis van de locatie van de begin halte, die wordt verkregen uit het object, wordt een Region object gecreëerd met een bepaalde radius. Deze Region wordt in een MKMapview geladen. MKMapview in een ingebakken kaart interface van Apple zelf. In de Mapview ziet de gebruiker naast de Region ook zijn eigen locatie. Wanneer de gebruiker binnen bepaalde afstand van de halte komt verschijnt er een notificatie met de reisdetails op het scherm. Deze details komen ook uit het object dat mee was gestuurd vanuit de SavedViewController.

## Challenges
Terugkijkend naar het project heb ik (bijna) al mijn doelen bereikt. Ik heb leren werken met Core Location, Core Data en verscheidende Google API's. Alle functies die ik wilde implementeren werken naar behoren. Echter werkt het Geofence, die kijkt of je in de buurt bent van een halte, alleen wanneer je in de RegionViewController zit. Hierdoor heeft deze functie uiteindelijk geen toegevoegde waarde. Om deze functionaliteit wel een toegevoedgde waarde te geven moest ik mijn applicatie teveel ombouwen. Het zou mij veel tijd gaan kosten zonder zekerheid of het daadwerkelijk zou werken. In plaats daarvan heb ik het Autocomplete scherm van de Google Places API geïmplementeerd in de SearhViewController. 

Ook zijn mijn vaardigheden om in objecten te programmeren, naar mijn mening, verbeterd.

## Decisions
Ik denk dat het een goede keuze is geweest om het Geofence te laten zoals het nu is. Hierdoor heb ik  tijd gehad om de autocomplete feature toe te voegen die de gebruikersvriendlijkheid en gebruikservaring verhoogt. Een ander voordeel van deze feature is het error handling. Deze is nu niet meer nodig omdat een gebruiker geen eindbestemmingen kan invoeren die niet bestaan, omdat de gebruiker alleen maar kan klikken op de suggesties van het autocomplete venster.

Met meer tijd zou ik het Geofence werkend krijgen zodat het ook op de achtergrond uitgevoerd wordt. Ook zou ik meer reisdetails opslaan in het Directions object, omdat de gebruiker nu alleen de beginhalte kan zien. Hierdoor kan de gebruiker geen tussenstops/overstapplekken bekijken.

Het ophalen van de huidige locatie duurt naar mijn mening te lang. Op het moment na de initializatie van het Core Location object zit een paar seconde tussen voordat de eerste functie in dit object automatisch wordt uitgevoerd. Ik heb niet kunnen achterhalen waarom dit zo lang duurt.

## Demo uitleg
De standaard locatie staat ingesteld op het Science Park. Ik heb dit gedaan aan de hand van een .gpx file. Hierin kan je coördinaten van een locatie instellen. De standaard locatie is ingesteld in het target build schema.




