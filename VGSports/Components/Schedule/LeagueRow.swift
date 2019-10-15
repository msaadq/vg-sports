//
//  LeagueRow.swift
//  VGSports
//
//  Created by Saad Qureshi on 14/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct LeagueRow: View {
    var league: LeagueListing
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image(uiImage: league.logo ?? UIImage(named: "FailedPlaceholder")!)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .shadow(radius: 10)
                Text(league.name)
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
            }
            .padding(.top)
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(self.league.events, id: \.self) { event in
                        NavigationLink(destination: MatchDetailsView(event: event)) {
                            EventItem(event: event)
                        }
                    }
                }
            }
            .frame(height: 220)
        }
    }
}

struct LeagueRow_Previews: PreviewProvider {
    static var previews: some View {
        LeagueRow(league: LeagueListing.loadSampleListings()![1])
    }
}
