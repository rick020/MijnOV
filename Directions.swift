//
//  Request.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 22/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import Foundation

class Directions {
    var starting_point: String
    var destination: String
    var directionDetails = [String: String]()
    var coordinates = [Double]()

    
    init(starting_point: String, destination: String) {
        self.starting_point = starting_point
        self.destination = destination
        handleRequest()
    }

    private func requestDirection() -> URLRequest{
        let key = "AIzaSyBxT6mhVJwxrUi6wKcfKr9nhTN5Kl7_X5A"
        
        self.starting_point = self.starting_point.replacingOccurrences(of: " ", with: "+")
        self.starting_point = self.starting_point.replacingOccurrences(of: ",", with: "")

        let webUrl = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(self.starting_point)&destination=\(self.destination)&mode=transit&key=\(key)")!
        var request = URLRequest(url: webUrl)
        request.httpMethod = "POST"
        return request
    }
    
    private func handleRequest() {
        URLSession.shared.dataTask(with: requestDirection(), completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let routes = json.value(forKey: "routes") as! NSArray
                let status = json.value(forKey: "status") as! String
                
                if (status == "ZERO_RESULTS"){
                    print("ZERO RESULTS")
                }
                else{
                    let legs = (routes[0] as AnyObject).value(forKey: "legs")! as! NSArray
                    let steps = (legs[0] as AnyObject).value(forKey: "steps")! as! [[String:Any]]
                    
                    for i in steps {
                        if(i["transit_details"] as? Dictionary<String,AnyObject> != nil) {
                            let transit_details = i["transit_details"] as! Dictionary<String,AnyObject>
                            let line = transit_details["line"] as! Dictionary<String,AnyObject>
                            let vehicleInfo = line["vehicle"] as! Dictionary<String,AnyObject>
                            
                            DispatchQueue.main.async {
                                self.directionDetails["headsign"] = transit_details["headsign"] as? String
                                self.directionDetails["shortName"] = line["short_name"] as? String
                                self.directionDetails["vehicleType"] = vehicleInfo["name"] as? String
                                self.directionDetails["departureStop"] = transit_details["departure_stop"]?.value(forKey: "name") as? String
                                
                                let coordinates = transit_details["departure_stop"]?.value(forKey: "location") as? Dictionary<String,Double>
                                let lat = coordinates!["lat"]!
                                let lng = coordinates!["lng"]!
                                self.coordinates.append(lat)
                                self.coordinates.append(lng)
                                
                                self.directionDetails["departureTime"] = transit_details["departure_time"]?.value(forKey: "text") as? String
                                NotificationCenter.default.post(name: Notification.Name("TransitDetailsAvailable"), object: nil)
                            }
                            
                            break
                        }
                    }
                }
            }
            catch {
                print(error)
            }}).resume()
    }
    
    func getHeadSign() -> String {
        if let details = self.directionDetails["headsign"] {
            return details
        }
        else {
            return "Not Found"
        }
    }
    func getShortName() -> String {
        if let details = self.directionDetails["shortName"] {
            return details
        }
        else {
            return "Not Found"
        }
    }
    func getVehicleType() -> String {
        if let details = self.directionDetails["vehicleType"] {
            return details
        }
        else {
            return "Not Found"
        }
    }
    func getDepartureStop() -> String {
        if let details = self.directionDetails["departureStop"] {
            return details
        }
        else {
            return "Not Found"
        }
    }
    func getDepartureTime() -> String {
        if let details = self.directionDetails["departureTime"] {
            return details
        }
        else {
            return "Not Found"
        }
    }
    
    func getCoordinates() -> [Double] {
        return self.coordinates
    }
    

}
