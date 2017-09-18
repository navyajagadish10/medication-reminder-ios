//
//  MedicationService.swift
//  medication-reminder
//
//  Created by Navya Jagadish on 9/15/17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MedicationServiceDelegate: class {
    
    func medicationRetrieved(medications: [Medications])
    
    func medicationRetrievedFailed(errorMessage: String)
    
}

class MedicationService: BaseService {
    
    weak var delegate: MedicationServiceDelegate?
    
    func dateConverter(str : String) -> NSDate {
        let str1 = str
        let formato = DateFormatter()
        formato.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formato.formatterBehavior = .default
        let changedDate = formato.date(from: str1)
        return (changedDate as NSDate?)!
    }
    
    func getMedications() {
        
        let medicationRouter = MedicationRouter.init(endPoint: .retrieveMedications())
        var medicationsArray = [Medications]()
        
        apiCall(input: medicationRouter, handler: { (responseData, error) in
            
            if(error != nil) {
                self.delegate?.medicationRetrievedFailed(errorMessage: error!.localizedDescription)
                
            } else {
                let responseDictionaryArr = responseData.arrayValue
                
                if responseDictionaryArr.count > 0 {
                    
                    for dictionaryVal in responseDictionaryArr {
                        
                        var medication = Medications()
                        medication.__v = dictionaryVal["__v"].int
                        medication.completed = dictionaryVal["completed"].boolValue
                        medication.dosage = dictionaryVal["dosage"].stringValue
                        medication.id = dictionaryVal["_id"].stringValue
                        medication.name = dictionaryVal["name"].stringValue
                        medication.tillTime = self.dateConverter(str: dictionaryVal["time"].stringValue) as NSDate?
                        
                        var dDataVal = dData()
                        var ddatadict = dictionaryVal["d"].dictionaryValue
                        dDataVal.cTime = self.dateConverter(str: (ddatadict["c"]?.stringValue)!) as NSDate?
                        print(ddatadict["c"]?.string as Any)
                        medication.d = dDataVal
                        
                        medicationsArray.append(medication)
                    }
                    
                }
                self.delegate?.medicationRetrieved(medications: medicationsArray)
            }
        })
    }
}
