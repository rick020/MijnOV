//
//  TransitTableViewCell.swift
//  ObjectAndClasses
//
//  Created by Rick Bruins on 22/01/2017.
//  Copyright © 2017 Mprog. All rights reserved.
//

import UIKit

class TransitTableViewCell: UITableViewCell {

    @IBOutlet weak var endpointLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        endpointLabel.text = endpointLabel.text?.replacingOccurrences(of: "+", with: " ")
        departureLabel.text = departureLabel.text?.replacingOccurrences(of: "+", with: " ")
        transportLabel.text = transportLabel.text?.replacingOccurrences(of: "+", with: " ")
        destinationLabel.text = destinationLabel.text?.replacingOccurrences(of: "+", with: " ")

    }
}

