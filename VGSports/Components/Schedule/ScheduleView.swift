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
            List(self.viewModel.listings) { listing in
                HStack {
                    Text(listing.name)
                }
            }
            Text("Hello Idiot")
        }.onAppear {
            self.viewModel.loadSchedule()
        }.onDisappear {
            self.viewModel.cancellable?.cancel()
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
