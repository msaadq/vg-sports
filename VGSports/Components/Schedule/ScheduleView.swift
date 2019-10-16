//
//  ScheduleView.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    @ObservedObject var viewModel = ScheduleVM()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.listings, id: \.id) { league in
                    LeagueRow(league: league).environmentObject(self.viewModel)
                    .listRowBackground(Color("BackgroundColor"))
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitle(Text("Today"))
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(named: "BackgroundColor")
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            self.viewModel.loadSchedule()
        }
        .onDisappear {
            self.viewModel.cancellable?.cancel()
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 6", "iPhone XS Max"], id: \.self) { deviceName in
            ScheduleView()
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
