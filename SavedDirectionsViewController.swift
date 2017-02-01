//
//  ViewController.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 22/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import UIKit
import CoreData

class SavedDirectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Directions] = []
    var userInfo = String()
    var transitDB: [NSManagedObject] = []
    var coreLocation: CoreLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTransitDetails(notification:)), name: Notification.Name("TransitDetailsAvailable"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(notification:)), name: Notification.Name("LocationAvailable"), object: nil)
        checkRefresh()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreLocation = CoreLocation()
        fetchTransit()
    }
    @objc private func refreshOptions(sender: UIRefreshControl) {
        coreLocation = CoreLocation()
        if userInfo != ""{
            fetchTransit()
        }
        sender.endRefreshing()
    }
    // Create array of directions objects
    func createDirections() {
        list = []
        for trans in transitDB as [NSManagedObject] {
            var destination = trans.value(forKey: "name") as! String
            destination = destination.replacingOccurrences(of: " ", with: "+")
            let myDirection = Directions(starting_point: self.userInfo, destination:destination)
            list.append(myDirection)
        }
        tableView.reloadData()
    }
    
    func handleTransitDetails(notification: Notification) {
        tableView.reloadData()
    }
    
    func locationAvailable(notification: Notification) {
        self.userInfo = notification.object as! String
        title = self.userInfo
        createDirections()
    }
    
    func checkRefresh() {
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = NSLocalizedString("PullToRefresh", comment: "Pull to refresh")
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }
    
    func fetchTransit() {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Destination")
        
        do {
            transitDB = try context.fetch(fetchRequest)

        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TransitTableViewCell
        let transit = transitDB[indexPath.row]
        let routeDirection = list[indexPath.row]
        let transportDetails = routeDirection.getVehicleType() + " " + routeDirection.getShortName() + " " + routeDirection.getHeadSign()
        cell.departureLabel.text = routeDirection.getDepartureTime()
        cell.endpointLabel.text = "Halte: " + routeDirection.getDepartureStop()
        cell.transportLabel.text = transportDetails
        cell.destinationLabel.text = transit.value(forKeyPath: "name") as? String
        return cell

    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let context = getContext()
            context.delete(transitDB[indexPath.row] )
            transitDB.remove(at: indexPath.row)
            list.remove(at: indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passLocation" {
            let vc = segue.destination as! SearchViewController
            if userInfo != "" {
                vc.userLocation = userInfo
            }
        }
        else if segue.identifier == "toRegion" {
            let destination = segue.destination as! RegionViewController
            if tableView.indexPathForSelectedRow?.row != nil{
                let cellIndex = tableView.indexPathForSelectedRow?.row
                let directions = list[cellIndex!]
                destination.directionObject = directions
            }
        }
    }
}

