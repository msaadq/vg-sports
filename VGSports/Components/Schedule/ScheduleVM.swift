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

public class ScheduleVM: ObservableObject {
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
                }
            }, receiveValue: {
                self.listings = $0
            })
    }
    
    func loadLeagueLogos() {
        let size = APIService.LogoSize.large
        
        for (index, league) in listings.enumerated() {
            let _ = APIService.shared.getLogoImageFetcher(imageUrl: league.logoUrl, size: size)
                .sink { self.listings[index].logos[size] = $0 }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
