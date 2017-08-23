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
    
    
    func load<A: Decodable>(resourcetype: A.Type, completion: @escaping (A?)   ->()) throws     {
        
        let resource = Resource(url: Service.url!)
        let request = URLRequest(url: resource.url)
        
        
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            do{
                if let error = error {
                    throw ResourceError.urlSessionError(error.localizedDescription)
                }
                guard let data = data else {
                    throw ResourceError.invalidResource
                }
                let result = resource.Generic(type: A.self, data: data)
                completion(result)
            }
            catch let blockError {
                print(blockError)
            }
            
        }.resume()
  }
}



public class Check {
    
    func loader() {
        
        do{
            try WebService().load(resourcetype: Recording.self, completion: { (result) in
                
                if let result = result {
                    print(result)
                }
                
            })
        }
        catch ResourceError.invalidResource {
            print(ResourceError.invalidResource.description)
        }
        catch ResourceError.urlSessionError(let message) {
            print(message.description)
        }
        catch let sysError {
            print(sysError)
        }
    }
}

