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
    @ObservedObject var vm = ScheduleVM()
    
    var body: some View {
        NavigationView {
            ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
            if !vm.connectionOffline {
                List {
                    ForEach(self.vm.listings, id: \.id) { league in
                        LeagueRow(league: league).environmentObject(self.vm)
                            .listRowBackground(Color.backgroundColor)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .navigationBarTitle(Text("Today"))
            }
            else {
                
                    VStack(alignment: .center, spacing: 40) {
                        Text("You are not connected to the internet. Press the button below to retry!")
                            .font(.body)
                            .foregroundColor(Color(UIColor.label))
                            .shadow(radius: 10)
                        Button(action: {
                            self.vm.loadSchedule()
                            
                        }) {
                            NavigationButton(text: "Retry ")
                        }
                    }
                    .padding(20)
                }
            }
            
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(named: "BackgroundColor")
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            self.vm.loadSchedule()
        }
        .onDisappear {
            self.vm.cancellable?.cancel()
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
