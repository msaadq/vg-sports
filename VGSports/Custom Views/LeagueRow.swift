//
//  LeagueRow.swift
//  VGSports
//
//  Created by Saad Qureshi on 14/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct LeagueRow: View {
    @EnvironmentObject var viewModel: ScheduleVM
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
                HStack(alignment: .top, spacing: 0) {
                    
                    // TODO: Move the single event cell to a separate struct once the SwiftUI bug is fixed
                    ForEach(self.league.events, id: \.self) { event in
                        NavigationLink(destination: MatchDetailsView(vm: MatchDetailsVM(event: event))) {
                            ZStack {
                                Rectangle()
                                    // TODO: User colors from the extensions file
                                    .fill(Color("CellColor"))
                                    .shadow(radius: 5)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .center) {
                                    Text(event.displayStartTime())
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(Color(UIColor.label))
                                    HStack(alignment: .center, spacing: 0) {
                                        EventTeamRep(logo: event.homeTeam.logo ?? UIImage(named: "FailedPlaceholder")!, teamName: event.homeTeam.name, isWinner: event.homeTeam.isWinner)
                                        VStack(spacing: 26) {
                                            HStack(alignment: .center) {
                                                Text("\(event.result.runningScore.home)")
                                                Text("-")
                                                Text("\(event.result.runningScore.away)")
                                            }
                                            .font(.title)
                                            .foregroundColor(Color(UIColor.label))
                                            .shadow(radius: 10)
                                            GameStatusDisplay(status: event.status.type)
                                        }
                                        EventTeamRep(logo: event.awayTeam.logo ?? UIImage(named: "FailedPlaceholder")!, teamName: event.awayTeam.name, isWinner: event.awayTeam.isWinner)
                                        
                                    }
                                }
                                .padding()
                            }
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
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
        Group {
            LeagueRow(league: LeagueListing.loadSampleListings()![1])
                .environment(\.colorScheme, .dark)
            
            LeagueRow(league: LeagueListing.loadSampleListings()![1])
                .environment(\.colorScheme, .light)
        }
    }
}
