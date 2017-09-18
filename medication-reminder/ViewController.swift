//
//  ViewController.swift
//  medication-reminder
//
//  Created by Vikas Gandhi on 2017-03-17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, MedicationServiceDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var currentDateAndTime: UILabel!
    @IBOutlet weak var medicationTableView: UITableView!
    
    var medicationsArray = [Medications]()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        medicationTableView.layer.cornerRadius = 5
        medicationTableView.layer.borderWidth = 2
        
        myView.layer.cornerRadius = 5
        myView.layer.borderWidth = 2
        
        let medicationService = MedicationService()
        medicationService.getMedications()
        medicationService.delegate = self
    }
    
    @objc func tick() {
        self.currentDateAndTime.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .medium)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableView Delegate and DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if medicationsArray.count > 0 {
            return medicationsArray.count
        }
        else {
            return 1
        }*/
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MedicationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MedicationTableViewCell
        
        if medicationsArray.count > 0 {
            cell.medicationName.text = medicationsArray[indexPath.row].name
        }
        else {
            cell.medicationName.text = "Loading ..."
        }
        
        return cell
    }
    
    
    // MARK: - Medication Service Delegate methods
    func medicationRetrieved(medications: [Medications]) {
        
        if medications.count > 0 {
            let today = NSDate().addingTimeInterval(0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let todayDate = dateFormatter.string(from: today as Date)
            print(todayDate)
            
            for item in medications {
                let ctime = item.d?.cTime?.addingTimeInterval(0)
                let dateFor = DateFormatter()
                dateFor.dateStyle = .medium
                let cTimeComp = dateFor.string(from: ctime! as Date)
                
                /*if cTimeComp == todayDate {
                    self.medicationsArray.append(item)
                }*/
                
                if cTimeComp.contains("Sep 14") {
                    self.medicationsArray.append(item)
                }
            }
        }
        print(medicationsArray.count)
        self.medicationTableView.reloadData()
    }
    
    func medicationRetrievedFailed(errorMessage: String) {
        print(errorMessage)
    }

}

