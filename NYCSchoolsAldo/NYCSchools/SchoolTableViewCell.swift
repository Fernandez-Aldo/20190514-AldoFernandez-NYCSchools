//
//  SchoolTableViewCell.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    func configureCell(title: String, id: String){
        titleLabel.text = title
        idLabel.text = id
    }

}
