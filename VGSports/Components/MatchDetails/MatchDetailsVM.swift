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
    @Published var eventDetails: SportEvent?
    @Published var connectionOffline = false
    
    var cancellable: AnyCancellable?

    func loadEventDetails() {
        cancellable = APIService.shared.GET(modelObject: SportEvent.self, endpoint: .eventDetails(eventId: 377462), params: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    self.connectionOffline = true
                case .finished:
                    print("Request Successful")
                }
            }, receiveValue: { self.eventDetails = $0 })
    }
    
    deinit {
        cancellable?.cancel()
    }
}
