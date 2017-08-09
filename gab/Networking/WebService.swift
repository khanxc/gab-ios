//
//  WebService.swift
//  gab
//
//  Created by khan on 09/08/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation
import UIKit

public final class WebService {
    
    
    func load<A: Decodable>(resourcetype: A.Type, completion: @escaping (A?) ->())  {
        
        let resource = Resource(url: Service.url!)
        let request = URLRequest(url: resource.url)
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            
           // data.flatMap(<#T##transform: (Data) throws -> U?##(Data) throws -> U?#>)
            
            let result = resource.Generic(type: A.self, data: data!)
            
            completion(result)
            
            
        }.resume()
  }
    
    
}


public final class Result {
    
    func dataResult() {
        
        WebService().load(resourcetype: Recording.self) { (data) in
            print(data!)
        }
        
    }
    
}
