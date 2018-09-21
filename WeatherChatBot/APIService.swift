//
//  Registration.swift
//  KongNaMul
//
//  Created by Justin Ji on 15/11/2017.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

class APIService {
    
    private init() { }
    
    static let shared = APIService()
    typealias completedClosure = ([String: Any]) -> Void
    func get(url: URL, completionHandler completion: @escaping completedClosure) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                    
                    DispatchQueue.main.async {
                        completion(json!)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
   
    
    
}


























































