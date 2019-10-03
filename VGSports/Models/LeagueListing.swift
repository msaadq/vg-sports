//
//  LeagueListing.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation

// MARK: - LeagueListing
struct LeagueListing: Codable, Identifiable {
    let id: Int
    let name: String
    let logoUrl: String
    let events: [SportEvent]
    
    let logos: [LogoService.Size:String]?
}

