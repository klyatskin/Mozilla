//
//  NetrworkFetch.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ data: Data?, _ error: Error?) -> Void

class NetworkFetch {
    
    func fetch(path: String, completion: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        
        let url = URL(string: path)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in

            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
        return task
    }
}
