//
//  Color.swift
//  VGSports
//
//  Created by Saad Qureshi on 15/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff


        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)

    }
    
    static var lightBlue: Color {
        return Color(hex: "afeeee")
    }
}
