//
//  SportEvent.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import UIKit

// MARK: - EventWrapper
struct EventWrapper: Codable {
    let event: SportEvent
}

// MARK: - SportEvent
struct SportEvent: Codable, Identifiable {
    let id: Int
    let startDate: String
    var homeTeam, awayTeam: Team
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

    private enum CodingKeys: String, CodingKey {
        case id, name, logoUrl, isWinner
    }

    var logos = [APIService.LogoSize:UIImage]()
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
