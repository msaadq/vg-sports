//
//  LeagueListing.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import UIKit

// MARK: - LeagueListing
struct LeagueListing: Codable, Identifiable {
    let id: Int
    let name: String
    let logoUrl: String
    
    var events: [SportEvent]

    private enum CodingKeys: String, CodingKey {
        case id, name, logoUrl, events
    }

    var logo : UIImage!
}

extension LeagueListing {
    static func loadSampleListings() -> [LeagueListing]? {
        let listings = """
        [
          {
            "id": 38,
            "name": "Eliteserien",
            "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/3e/3e371e7a-988b-478a-b517-ba8d84f921a3",
            "events": [
              {
                "id": 377462,
                "startDate": "2019-08-31T16:00:00Z",
                "homeTeam": {
                  "id": "22984",
                  "name": "Stabæk",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/d0/d040451e-176c-4c83-a2ea-37667dfc0e7f",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "22981",
                  "name": "Strømsgodset",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/fe/fe5e69cb-0627-477f-bbb1-20e19d174a1d",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 0,
                    "away": 0
                  }
                },
                "status": {
                  "type": "notStarted"
                }
              }
            ]
          },
          {
            "id": 3,
            "name": "Premier League",
            "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/3a/3a51232f-dd83-4ae0-8989-dcbe4c537cc2",
            "events": [
              {
                "id": 389096,
                "startDate": "2019-08-31T11:30:00Z",
                "homeTeam": {
                  "id": "1746",
                  "name": "Southampton",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/8d/8df6d3dd-ee77-435d-87f7-bb81701c47da",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "1751",
                  "name": "Manchester United",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/06/06b4fcfa-40f1-45fb-99fc-c3172123a553",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 0,
                    "away": 0
                  }
                },
                "status": {
                  "type": "notStarted"
                }
              },
              {
                "id": 389090,
                "startDate": "2019-08-31T14:00:00Z",
                "homeTeam": {
                  "id": "1754",
                  "name": "Chelsea",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/79/797f8863-875e-4af1-97ae-04265a0be40b",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "20087",
                  "name": "Sheffield United",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/44/44606359-3954-4b5e-b880-16de84970e4e",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 0,
                    "away": 0
                  }
                },
                "status": {
                  "type": "notStarted"
                }
              },
              {
                "id": 389091,
                "startDate": "2019-08-31T14:00:00Z",
                "homeTeam": {
                  "id": "1740",
                  "name": "Crystal Palace",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/da/da9a12da-2d41-4b35-8699-b92d30996861",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "20092",
                  "name": "Aston Villa",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/6c/6ca4dcc8-4f9e-4574-ba21-e2830fbd6383",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 0,
                    "away": 0
                  }
                },
                "status": {
                  "type": "notStarted"
                }
              },
              {
                "id": 389093,
                "startDate": "2019-08-31T14:00:00Z",
                "homeTeam": {
                  "id": "1737",
                  "name": "Leicester City",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/50/502b4330-16ec-4b30-ab89-8cef350b1c06",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "1750",
                  "name": "AFC Bournemouth",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/b9/b90d716a-d2f3-4dca-9110-0067337eaf3d",
                  "isWinner": false
                },
                "tournamentRound": "4",
                "result": {
                  "runningScore": {
                    "home": 1,
                    "away": 4
                  }
                },
                "status": {
                  "type": "inProgress"
                }
              },
              {
                "id": 389094,
                "startDate": "2019-08-31T14:00:00Z",
                "homeTeam": {
                  "id": "1748",
                  "name": "Manchester City",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/0c/0cddbff0-4b53-4199-9423-4f36fd531c87",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "20746",
                  "name": "Brighton & Hove Albion",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/65/6570b669-63ce-49ef-a440-e8b73f2e7355",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 3,
                    "away": 0
                  }
                },
                "status": {
                  "type": "inProgress"
                }
              },
              {
                "id": 389095,
                "startDate": "2019-08-31T14:00:00Z",
                "homeTeam": {
                  "id": "20743",
                  "name": "Newcastle United",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/63/6341f6b4-123c-4747-ab3a-b42520bb9258",
                  "isWinner": false
                },
                "awayTeam": {
                  "id": "1747",
                  "name": "Watford",
                  "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/be/bed1a1a1-361e-4c22-b666-d34c516057d0",
                  "isWinner": false
                },
                "result": {
                  "runningScore": {
                    "home": 0,
                    "away": 0
                  }
                },
                "status": {
                  "type": "finished"
                }
              }
            ]
          }
        ]
        """

        if let jsonData = listings.data(using: .utf8) {
            do {
                let event = try JSONDecoder().decode([LeagueListing].self, from: jsonData)
                return event
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}


