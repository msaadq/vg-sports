//
//  MatchDetailsView.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct MatchDetailsView: View {
    @ObservedObject var viewModel: MatchDetailsVM
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.eventDetails.awayTeam.logo)
            Text("eve")
        }
        .onAppear() {
            self.viewModel.loadEventDetails()
        }
        .onDisappear {
            self.viewModel.cancellable?.cancel()
        }
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(viewModel: MatchDetailsVM(event: SportEvent.loadSampleEvent()!))
    }
}
