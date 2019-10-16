//
//  EventTeamRep.swift
//  VGSports
//
//  Created by Saad Qureshi on 16/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation
import SwiftUI

struct EventTeamRep: View {
    var logo: UIImage
    var teamName: String
    var isWinner: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: logo)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .shadow(radius: 10)
                .padding()
            Text(teamName)
                .foregroundColor(.primary)
                .font(.callout)
                .shadow(radius: 10)
                .lineLimit(1)
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

struct EventTeamRep_Previews: PreviewProvider {
    static var previews: some View {
        EventTeamRep(logo: UIImage(named: Constants.Placeholders.failure)!, teamName: "Manchester United", isWinner: true)
    }
}

