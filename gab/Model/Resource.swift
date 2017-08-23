//
//  Resource.swift
//  gab
//
//  Created by khan on 09/08/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation

/*
 
 * Generic result type from server
 * A resource can take any date model as input
 * And deserialize json into respective data model
 
*/


protocol GenericDecoding {
    
 func Generic<obj>(type: obj.Type, data: Data) -> obj? where obj : Decodable
    
}

struct Resource {
    
      let url: URL
       
}

extension Resource : GenericDecoding {
    
    
    func Generic<obj>(type: obj.Type, data: Data) -> obj? where obj : Decodable  {
        
        let decoded = try? JSONDecoder().decode(type, from: data)
        return decoded
    }
}



