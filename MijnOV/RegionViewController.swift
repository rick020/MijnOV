//
//  RegionViewController.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 24/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RegionViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var directionObject: Directions?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        setupData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            
        else if CLLocationManager.authorizationStatus() == .denied {
            alert(title: "Error", message: "Location services were previously denied. Please enable location services for this app in Settings.")
        }
            
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func setupData() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {

            if directionObject != nil && (directionObject!.coordinates.count) > 0{
                title = directionObject!.getDepartureStop()
                
                let coordinate = CLLocationCoordinate2DMake((directionObject?.coordinates[0])!,(directionObject?.coordinates[1])!)
                let regionRadius = 100.0
                let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude), radius: regionRadius, identifier: (directionObject?.getDepartureTime())! )
                
                locationManager.startMonitoring(for: region)
                let departureAnnotation = MKPointAnnotation()
                departureAnnotation.coordinate = coordinate;
                departureAnnotation.title = title!
                departureAnnotation.subtitle = directionObject!.getDepartureTime() + " " + directionObject!.getVehicleType() + " " + directionObject!.getShortName() + " " + directionObject!.getHeadSign()

                mapView.addAnnotation(departureAnnotation)
                let circle = MKCircle(center: coordinate, radius: regionRadius)
                mapView.add(circle)
            }
        }
        else {
            alert(title: "Error", message: "System can't track regions")
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.orange
        circleRenderer.fillColor = UIColor.orange.withAlphaComponent(0.4)
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        alert(title: "Enter", message: directionObject!.getDepartureTime() + " " + directionObject!.getVehicleType() + " " + directionObject!.getShortName() + " " + directionObject!.getHeadSign())
        
    }
}
