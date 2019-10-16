//
//  GameStatusDisplay.swift
//  VGSports
//
//  Created by Saad Qureshi on 16/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct GameStatusDisplay: View {
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


struct GameStatusDisplay_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameStatusDisplay(status: .notStarted)
            GameStatusDisplay(status: .inProgress)
            GameStatusDisplay(status: .finished)
        }
    }
}
