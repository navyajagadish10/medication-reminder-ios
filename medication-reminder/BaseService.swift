//
//  BaseService.swift
//  medication-reminder
//
//  Created by Navya Jagadish on 9/15/17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseService {
    
    typealias jsonCompletionClosure = (JSON, Error?) -> Void
    let sessionManager = Alamofire.SessionManager.default
    
    private var accessToken: String?
    
    func apiCall(input: BaseRouter, handler responseHandler: @escaping jsonCompletionClosure) {
        
        print(input.URL)
        print(input.method)
        print(input.parameters as Any)
        print(input.encoding)
        print(input.headers!)
        
        sessionManager.request(input.URL, method: input.method, parameters: input.parameters, encoding: input.encoding, headers: input.headers).validate().responseJSON {
            (response) in
            
            switch(response.result) {
            case .success(_):
                
                let responseData = JSON(response.result.value!)
                if response.result.error != nil {
                    responseHandler(JSON.null, response.result.error)
                } else {
                    responseHandler(responseData, nil)
                }
                
                break
                
            case .failure(_):
                responseHandler(JSON(data: response.data!), response.result.error)
                break
                
            }
        }
        
    }
    
}
