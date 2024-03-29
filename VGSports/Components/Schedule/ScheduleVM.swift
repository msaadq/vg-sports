//
//  ScheduleVM.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import Combine
import UIKit

// MARK: - ScheduleVM
public class ScheduleVM: ObservableObject {
    
    // MARK: - Public API
    @Published var listings = [LeagueListing]()
    @Published var connectionOffline = false
    
    var cancellable: AnyCancellable?

    func loadSchedule() {
        guard Reachability.isConnectedToNetwork() else {
            connectionOffline = true
            return
        }

        connectionOffline = false
        cancellable = APIService.shared.getAPIResponseMapper(modelObject: [LeagueListing].self, endpoint: .events, params: ["date": "today"])
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    self.loadLeagueLogos()
                    self.loadEventTeamsLogos()
                }
            }, receiveValue: {
                self.listings = $0
            })
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    // MARK: - Private Methods
    private func loadLeagueLogos() {
        let size = APIService.LogoSize.large
        
        for (index, league) in listings.enumerated() {
            let _ = APIService.shared.getLogoImageFetcher(imageUrl: league.logoUrl, size: size)
                .sink { self.listings[index].logo = $0 }
        }
    }
    
    private func loadEventTeamsLogos() {
        let size = APIService.LogoSize.large
        for (leagueIndex, league) in listings.enumerated() {
                for (index, event) in league.events.enumerated() {
                    let _ = APIService.shared.getLogoImageFetcher(imageUrl: event.homeTeam.logoUrl, size: size)
                        .sink { self.listings[leagueIndex].events[index].homeTeam.logo = $0 }

                    let _ = APIService.shared.getLogoImageFetcher(imageUrl: event.awayTeam.logoUrl, size: size)
                        .sink { self.listings[leagueIndex].events[index].awayTeam.logo = $0 }
                }
            }
    }
}
