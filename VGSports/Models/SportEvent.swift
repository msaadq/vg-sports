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
struct SportEvent: Codable, Hashable, Identifiable {
    let id: Int
    let startDate: Date
    let venue: Venue?
    let status: Status
    let result: Result
    let referee: String?
    let tvChannel: String?
    
    var tournamentRound: String?
    var homeTeam, awayTeam: Team
}

// MARK: - Team
struct Team: Codable {
    let id, name: String
    let logoUrl: String
    let isWinner: Bool

    private enum CodingKeys: String, CodingKey {
        case id, name, logoUrl, isWinner
    }

    var logo : UIImage!
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
    let type: StatusType
    
    enum StatusType: String, CaseIterable, Codable, Hashable {
        case notStarted = "notStarted"
        case inProgress = "inProgress"
        case finished = "finished"
    }
}

// MARK: - Venue
struct Venue: Codable {
    let name, city: String
}

// MARK: - Custom Date Decoding and sample JSON
extension SportEvent {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        homeTeam = try container.decode(Team.self, forKey: .homeTeam)
        awayTeam = try container.decode(Team.self, forKey: .awayTeam)
        venue = try? container.decode(Venue.self, forKey: .venue)
        status = try container.decode(Status.self, forKey: .status)
        result = try container.decode(Result.self, forKey: .result)
        referee = try? container.decode(String.self, forKey: .referee)
        tvChannel = try? container.decode(String.self, forKey: .tvChannel)
        tournamentRound = try? container.decode(String.self, forKey: .tournamentRound)

        let dateString = try container.decode(String.self, forKey: .startDate)
        if let date = DateFormatter.vgDateFormat.date(from: dateString) {
            startDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .startDate,
                  in: container,
                  debugDescription: "Unexpected Date string.")
        }
    }
    
    static func == (lhs: SportEvent, rhs: SportEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func loadSampleEvent() -> SportEvent? {
        let sampleEvent = """
        {
          "id": 389091,
          "startDate": "2019-08-31T14:00:00Z",
          "homeTeam": {
            "id": "1740",
            "name": "Crystal Palace",
            "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/da/da9a12da-2d41-4b35-8699-b92d30996861",
            "isWinner": true
          },
          "awayTeam": {
            "id": "20092",
            "name": "Aston Villa",
            "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/6c/6ca4dcc8-4f9e-4574-ba21-e2830fbd6383",
            "isWinner": false
          },
          "venue": {
            "name": "Selhurst Park",
            "city": "London"
          },
          "status": {
            "type": "finished"
          },
          "result": {
            "runningScore": {
              "home": 0,
              "away": 0
            }
          }
        }
        """

        if let jsonData = sampleEvent.data(using: .utf8) {
            do {
                let event = try JSONDecoder().decode(SportEvent.self, from: jsonData)
                return event
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func displayStartTime() -> String {
        let hours = Calendar.current.component(.hour, from: self.startDate)
        let minutes = Calendar.current.component(.minute, from: self.startDate)
        
        if Calendar.current.isDateInToday(self.startDate) {
            if hours <= 1 {
                return "in \(minutes) minutes"
            } else {
                return "in \(hours) hours"
            }
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: self.startDate)
        }
    }
    
    func displayStartTimeWithDate() -> String {
        let hours = Calendar.current.component(.hour, from: self.startDate)
        let minutes = Calendar.current.component(.minute, from: self.startDate)
        
        if Calendar.current.isDateInToday(self.startDate) {
            if hours <= 1 {
                return "in \(minutes) minutes"
            } else {
                return "in \(hours) hours"
            }
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return "at \(dateFormatter.string(from: self.startDate)) \(self.displayStartDate())"
        }
    }
    
    private func displayStartDate() -> String {
        if Calendar.current.isDateInToday(self.startDate) {
            return ""
        }
        else if Calendar.current.isDateInTomorrow(self.startDate) {
            return "Tomorrow"
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            return "on \(dateFormatter.string(from: self.startDate))"
        }
    }
}


// MARK: - Full Venue
extension Venue {
    func getVenue() -> String {
        return "\(self.name), \(self.city)"
    }
}




