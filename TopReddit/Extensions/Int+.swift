//
//  Int+.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import Foundation

extension Int {
    func getHour() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let interval = Date() - date
        
        if let hour = interval.hour {
            return String(hour)
        }
        return ""
    }
}
