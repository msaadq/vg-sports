//
//  EventItem.swift
//  VGSports
//
//  Created by Saad Qureshi on 14/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct EventItem: View {
    var event: SportEvent
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("CellColor"))
                .shadow(radius: 5)
                .cornerRadius(20)
            
            VStack(alignment: .center) {
                Text(event.displayStartTime())
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color(UIColor.label))
                HStack(alignment: .center, spacing: 0) {
                    EventTeam(logo: event.homeTeam.logo ?? UIImage(named: "FailedPlaceholder")!, teamName: event.homeTeam.name, isWinner: event.homeTeam.isWinner)
                    VStack(spacing: 26) {
                        HStack(alignment: .center) {
                            Text("\(event.result.runningScore.home)")
                            Text("-")
                            Text("\(event.result.runningScore.away)")
                        }
                        .font(.title)
                        .foregroundColor(Color(UIColor.label))
                        .shadow(radius: 10)
                        GameStatus(status: event.status.type)
                    }
                    EventTeam(logo: event.awayTeam.logo ?? UIImage(named: "FailedPlaceholder")!, teamName: event.awayTeam.name, isWinner: event.awayTeam.isWinner)
                    
                }
            }
                .padding()
        }
        .padding(.leading, 15)
        
    }
}

struct EventTeam: View {
    var logo: UIImage
    var teamName: String
    var isWinner: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: logo)
                .resizable()
                .foregroundColor(Color(UIColor.label))
                .aspectRatio(contentMode: .fit)
                .frame(width: 112, height: 112)
                .shadow(radius: 10)
            Text(teamName)
                .foregroundColor(.primary)
                .font(.callout)
                .shadow(radius: 10)
            isWinner ?
            Text("Winner")
                .italic()
                .font(Font.caption):
            Text("")
                .italic()
                .font(Font.caption)
            
        }
    }
}

struct GameStatus: View {
    var status: Status.StatusType
    
    var color: Color {
        switch status {
        case .finished:
            return .green
        case .inProgress:
            return .yellow
        case .notStarted:
            return .red
        }
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .shadow(radius: 5)
            .frame(width: 12, height: 12)
    }
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventItem(event: SportEvent.loadSampleEvent()!)
            .environment(\.colorScheme, .light)
            
            EventItem(event: LeagueListing.loadSampleListings()![1].events[5])
            .environment(\.colorScheme, .dark)
        }
    }
}
