//
//  SuggestionCache.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation


class SuggestionCache {
    
    static let shared = SuggestionCache()
    private var cache:  [String: Suggestions] = [:]
    
    func cachedSuggestionsFor(_ string: String) -> Suggestions? {
        return cache[string]
    }
 
    func cacheSuggestionsFor(_ string: String, suggestions:Suggestions) {
        cache[string] = suggestions;
    }
    
}
