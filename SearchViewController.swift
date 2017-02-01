//
//  SearchViewController.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 23/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces

class SearchViewController: UIViewController,UITextFieldDelegate {
    
    var userLocation = String()
    var transitDB: [NSManagedObject] = []
    let autocompleteController = GMSAutocompleteViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        autocompleteController.delegate = self
        present(autocompleteController, animated: false, completion: nil)
    }
        
    func saveInCoreData(destination: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Destination", in: managedContext)!
        let transit = NSManagedObject(entity: entity, insertInto: managedContext)
        transit.setValue(destination, forKeyPath: "name")
        
        do {
            try managedContext.save()
            transitDB.append(transit)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.saveInCoreData(destination: place.formattedAddress!)
        dismiss(animated: false, completion: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: false, completion: nil)
        _ = navigationController?.popViewController(animated: false)

    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
