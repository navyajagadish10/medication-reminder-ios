//
//  Medications.swift
//  medication-reminder
//
//  Created by Navya Jagadish on 9/16/17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import Foundation

struct dData {
    var cTime : NSDate?
}

struct Medications {
    var id : String?
    var dosage : String?
    var tillTime : NSDate?
    var __v : Int?
    var d : dData?
    var completed : BooleanLiteralType?
    var name : String?
}
