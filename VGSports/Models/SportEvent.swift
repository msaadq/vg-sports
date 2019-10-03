//
//  SportEvent.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation

// MARK: - SportEvent
struct SportEvent: Codable, Identifiable {
    let id: Int
    let startDate: String
    let homeTeam, awayTeam: Team
    let venue: Venue?
    let status: Status
    let result: Result
    let referee: String?
    let tvChannel: String?
}

// MARK: - Team
struct Team: Codable {
    let id, name: String
    let logoUrl: String
    let isWinner: Bool
    
    let logos: [LogoService.Size:String]?
}

// MARK: - Result
struct Result: Codable {
    let runningScore: RunningScore
}

// MARK: - RunningScore
struct RunningScore: Codable {
    let home, away: Int
}

// MARK: - Status
struct Status: Codable {
    let type: String
}

// MARK: - Venue
struct Venue: Codable {
    let name, city: String
}


