//
//  Icons.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

struct IconFont {
    static let name = "FontAwesome"
    
    static let sizeS = 12
    static let sizeM = 24
    static let sizeL = 36
    static let sizeXL = 48
}

struct Icons {
    static let hospitality = ""
    static let technology = ""
    static let music = ""
    static let media = ""
    static let fashion = ""
    static let graphicDesign = ""
    static let publishing = ""
    static let finance = ""
    static let govt = ""
    static let education = ""
    
    static func returnIcon(for string: String) -> String {
        switch string {
        case "Hospitality":
            return hospitality
        case "Technology":
            return technology
        case "Music":
            return music
        case "Media":
            return media
        case "Fashion":
            return fashion
        case "Graphic Design":
            return graphicDesign
        case "Publishing":
            return publishing
        case "Finance":
            return finance
        case "Government":
            return govt
        case "Education":
            return education
        default:
            return "error"
        }
    }
}
