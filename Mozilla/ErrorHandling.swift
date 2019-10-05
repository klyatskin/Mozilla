//
//  ErrorHandling.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation


class ErrorHandling {
    
    class func dump(_ err : Error) { // could be an alert raised...
        let error = err as NSError
        if (error.code != NSURLErrorCancelled) {
            print("❌: Failed to load: \(error.localizedDescription)")
        }
    }
    
    class func notSupported(_ str: String) {
        print("❌: " + str)
    }
}
