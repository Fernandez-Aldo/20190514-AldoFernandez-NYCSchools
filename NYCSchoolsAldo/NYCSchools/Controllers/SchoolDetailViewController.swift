//
//  SchoolDetailViewController.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avgCriticalLabel: UILabel!
    @IBOutlet weak var avgMathLabel: UILabel!
    @IBOutlet weak var avgWritingLabel: UILabel!
    @IBOutlet weak var numOfSatTakers: UILabel!
    
    var school : School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.text = "School: \(school?.name ?? "")"
        numOfSatTakers.text = "Number of SAT takers: \(school?.numOfParticipantsSAT ?? "No data")"
        avgCriticalLabel.text = "Avg. Critical Thinking Scores : \(school?.critcalReadAvgScoresSAT ?? "No data")"
        avgWritingLabel.text = "Avg. Writing Scores : \(school?.writingAvgScoresSAT ?? "No data")"
        avgMathLabel.text = "Avg. Math Scores : \(school?.mathAvgScoresSAT ?? "No data")"
    }
    

}
