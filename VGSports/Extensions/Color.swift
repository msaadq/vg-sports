//
//  Color.swift
//  VGSports
//
//  Created by Saad Qureshi on 16/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: Color: both dark mode and light mode versions of the colors are available in Assets file
extension Color {
    public static var backgroundColor: Color {
        Color("BackgroundColor", bundle: nil)
    }
    
    public static var cellColor: Color {
        Color("CellColor", bundle: nil)
    }
}

