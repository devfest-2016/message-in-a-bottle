//
//  Date.swift
//  message-in-a-bottle
//
//  Created by Christopher Boynton on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

extension Date {
    func formatted(as string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        
        return dateFormatter.string(from: self)
    }
    
    var weekday: String {
        switch Calendar.current.component(.weekday, from: self) {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Error"
        }
    }
    
    
}
