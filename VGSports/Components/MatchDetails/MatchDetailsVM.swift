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
                print("finished")
//                    self.loadEventTeamsLogos()
               }
           }, receiveValue: {
                self.eventDetails = $0.event
           })
    }

    deinit {
        cancellable?.cancel()
    }
}
