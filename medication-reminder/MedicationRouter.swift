//
//  MedicationRouter.swift
//  medication-reminder
//
//  Created by Navya Jagadish on 9/16/17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum MedicationEndPoint {
    case retrieveMedications()
}

class MedicationRouter: BaseRouter {
    
    var endPoint: MedicationEndPoint
    
    init(endPoint:MedicationEndPoint){
        self.endPoint = endPoint
    }
    
    override var method: Alamofire.HTTPMethod {
        switch endPoint {
        case .retrieveMedications():
            return .get
        }
    }
    
    override var parameters: APIParams {
        switch endPoint {
        case .retrieveMedications():
            return nil
        }
    }
    
    override var headers: APIHeaders {
        switch endPoint {
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    override var encoding: ParameterEncoding {
        switch endPoint {
        case .retrieveMedications():
            return URLEncoding.default
        }
    }
}
