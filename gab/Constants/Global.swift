//
//  Global.swift
//  gab
//
//  Created by khan on 04/08/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation
import UIKit


/*
 Configs for Recording Controller
 
*/







/*
 
 Web service URLs
 
 */

public struct Service {
    
   static let url = URL(string: "https://www.google.com")
}


/*
 
 Enumerate through types of Resource errors
 
 */
public enum ResourceError: Error {
    
    
    
    case invalidResource
    case urlSessionError(String)
    
    
}

/*
 
 ResourceError error constants
 
*/

extension ResourceError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case    .invalidResource : return "Oops something went wrong"
        case    .urlSessionError(let sessionsError): return sessionsError
        }
    }
}


