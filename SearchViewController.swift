//
//  SearchViewController.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 23/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    var userLocation = String()
    var transitDB: [NSManagedObject] = []

    @IBOutlet weak var startLocationField: UITextField!
    @IBOutlet weak var destinationField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func getCurrentLocation(_ sender: Any) {
        startLocationField.text = userLocation
    }
    
    @IBAction func saveRoute(_ sender: Any) {
        guard let start = startLocationField.text, !start.isEmpty else {
            alert(title: "Error", message: "start location empty field")
            return
        }
        guard let destination = destinationField.text,!destination.isEmpty else {
            alert(title: "Error", message: "end location is empty")
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Destination", in: managedContext)!
        let transit = NSManagedObject(entity: entity, insertInto: managedContext)
        transit.setValue(destination, forKeyPath: "name")
        
        do {
            try managedContext.save()
            transitDB.append(transit)
            print("succeed")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        
    }
}
