//
//  SuggestionFetch.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation


class SuggestionFetch: NetworkFetch {
    
    typealias SearchCompletionHandler =  (_ suggestions: [Suggestion], _ error: Error?) -> Void
    private let endPoint = "https://api.bing.com/osjson.aspx?query="
    static var lastTask: URLSessionDataTask?
    
    func fetchSearchSuggestions(searchStr: String, completion: @escaping SearchCompletionHandler) {
        
        guard let queryString = searchStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            ErrorHandling.notSupported("string format not supported")
            return
        }
        SuggestionFetch.lastTask?.cancel() // stop any previously created task
        SuggestionFetch.lastTask = fetch(path: endPoint + queryString) { (data, error) in
            guard let data = data else {
                ErrorHandling.dump(error!)
                completion([], error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let result = json as? [AnyObject], let suggestions = result.last as? Suggestions else {
                    ErrorHandling.notSupported("json format not supported")
                    return
                }
                completion(suggestions, nil)
            } catch let error as NSError {
                ErrorHandling.dump(error)
            }
        }
    }
}


