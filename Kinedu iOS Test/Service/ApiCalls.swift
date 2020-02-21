//
//  ApiCalls.swift
//  Kinedu iOS Test
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 Appsodi. All rights reserved.
//

import Foundation

class ApiCalls: NSObject {
    let baseURL = "http://demo.kinedu.com/bi/nps"
    
    static let sharedInstance = ApiCalls()
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    
    func getNpsData(completion: ((Result<[NPS]>) -> Void)?) {
        
        let url = URL(string: "\(baseURL)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config
        )
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                
                if let error = responseError {
                    completion?(.failure(error))
                    print(error)
                } else if let jsonData = responseData {
                    do {
                        let decoder = JSONDecoder()
                        let npsData = try decoder.decode([NPS].self, from: jsonData)
                        completion?(.success(npsData))
                        
                    } catch {
                        completion?(.failure(error))
                        print(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    print(completion?(.failure(error)) as Any)
                }
            }
        }
        task.resume()
    }
    
}
