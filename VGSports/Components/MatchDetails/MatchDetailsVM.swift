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
    
    init(event: SportEvent) {
        self.eventDetails = event
    }

    func loadEventDetails() {
        guard Reachability.isConnectedToNetwork() else {
            connectionOffline = true
            return
        }
        
        connectionOffline = false
        cancellable = APIService.shared.getAPIResponseMapper(modelObject: EventWrapper.self, endpoint: .eventDetails(eventId: eventDetails.id))
           .sink(receiveCompletion: { (completion) in
               switch completion {
               case .failure(let error):
                    print(error.localizedDescription)
               case .finished:
                print("finished")
               }
           }, receiveValue: {
                self.eventDetails = MatchDetailsVM.mergeEvents(event1: self.eventDetails, event2: $0.event)
           })
    }
    
    deinit {
        cancellable?.cancel()
    }
}

extension MatchDetailsVM {
    static func mergeEvents(event1: SportEvent, event2: SportEvent) -> SportEvent {
        var mergedEvent = event2
        mergedEvent.homeTeam.logo = event1.homeTeam.logo
        mergedEvent.awayTeam.logo = event1.awayTeam.logo
        mergedEvent.tournamentRound = event1.tournamentRound
        
        return mergedEvent
    }
}
