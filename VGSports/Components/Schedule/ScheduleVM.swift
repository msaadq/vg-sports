//
//  ScheduleVM.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import Combine

public class ScheduleVM: ObservableObject {
    @Published var listings = [LeagueListing]()
    @Published var connectionOffline = false
    
    var cancellable: AnyCancellable?

    func loadSchedule() {
        cancellable = APIService.shared.GET(modelObject: [LeagueListing].self, endpoint: .events, params: ["date": "today"])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    self.connectionOffline = true
                case .finished:
                    print("Request Successful")
                }
            }, receiveValue: { self.listings = $0 })
    }
    
    deinit {
        cancellable?.cancel()
    }
}
