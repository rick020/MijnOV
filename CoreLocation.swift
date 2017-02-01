//
//  CoreLocation.swift
//  MijnOV
//
//  Created by Rick Bruins on 23/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import Foundation
import CoreLocation


class CoreLocation : NSObject, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation])
    {
        if let location: CLLocation = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, e) -> Void in
                if e != nil {
                    print("Error:  \(e?.localizedDescription)")
                } else {
                    let placemark = (placemarks?.last)! as CLPlacemark
                    let userInfo = (placemark.addressDictionary!["FormattedAddressLines"] as! [String]).joined(separator: ", ")
                    NotificationCenter.default.post(name: Notification.Name("LocationAvailable"), object:userInfo)
                }
            })
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}
