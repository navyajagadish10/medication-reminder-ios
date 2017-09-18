//
//  BaseRouter.swift
//  medication-reminder
//
//  Created by Navya Jagadish on 9/15/17.
//  Copyright © 2017 Vikas Gandhi. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String : AnyObject]?
typealias APIHeaders = [String : String]?

protocol APIConfiguration {
    var method: Alamofire.HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
    var headers: APIHeaders { get }
    var URL: String { get }
}

class BaseRouter : APIConfiguration {
    
    static var URLstring: String{
        return Constants.URL.developmentBaseURL.rawValue
    }
    
    init() {}
    
    var method: HTTPMethod {
        fatalError("must be overridden in subclass")
    }
    
    var encoding: ParameterEncoding {
        fatalError("must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("must be overridden in subclass")
    }
    
    var baseUrl: String {
        return BaseRouter.URLstring
    }
    
    var headers: APIHeaders {
        return [:]
    }
    
    var URL: String {
        return "\(BaseRouter.URLstring)"
    }
    
}
