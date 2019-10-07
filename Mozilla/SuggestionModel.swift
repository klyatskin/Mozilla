//
//  SuggestionModel.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation
import UIKit

typealias Suggestion = String
typealias Suggestions = [Suggestion]


class SuggestionModel {
    
    var suggestionsToShow: Suggestions?
    let cache = SuggestionCache.shared

    func updateFor(searchStr: String, controller: MainViewController) {
      
        suggestionsToShow = cache.cachedSuggestionsFor(searchStr) ?? nil
        if (suggestionsToShow == nil) {
            let fetchCompletion: SuggestionFetch.SearchCompletionHandler = {
                    (suggestions: [Suggestion], _ error: Error?) -> Void  in
                
                    if (error == nil) {
                        DispatchQueue.main.async { [weak self, weak controller] in
                            self!.cache.cacheSuggestionsFor(searchStr, suggestions: suggestions)
                            self!.suggestionsToShow = suggestions
                            controller!.updateUIFor(searchStr: searchStr)
                        }
                    }
                }
            SuggestionFetch().fetchSearchSuggestions(searchStr: searchStr, completion: fetchCompletion )
        } else {
            controller.updateUIFor(searchStr: searchStr)
        }
    }
}
