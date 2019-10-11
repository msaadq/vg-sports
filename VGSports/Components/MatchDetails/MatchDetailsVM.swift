//
//  MatchDetailsVM.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import Combine

public class MatchDetailsVM: ObservableObject {
    @Published var eventDetails: SportEvent!
    @Published var connectionOffline = false
    
    var cancellable: AnyCancellable?

    func loadEventDetails(eventID: Int) {
        guard Reachability.isConnectedToNetwork() else {
            connectionOffline = true
            return
        }
        
        connectionOffline = false
        cancellable = APIService.shared.getAPIResponseMapper(modelObject: EventWrapper.self, endpoint: .eventDetails(eventId: eventID))
           .sink(receiveCompletion: { (completion) in
               switch completion {
               case .failure(let error):
                    print(error.localizedDescription)
               case .finished:
                    self.loadEventTeamsLogos()
               }
           }, receiveValue: {
                self.eventDetails = $0.event
           })
    }

    func loadEventTeamsLogos() {
        let size = APIService.LogoSize.large
        
        let _ = APIService.shared.getLogoImageFetcher(imageUrl: eventDetails.homeTeam.logoUrl, size: size)
            .sink { self.eventDetails.homeTeam.logos[size] = $0 }

        let _ = APIService.shared.getLogoImageFetcher(imageUrl: eventDetails.awayTeam.logoUrl, size: size)
            .sink { self.eventDetails.awayTeam.logos[size] = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}
