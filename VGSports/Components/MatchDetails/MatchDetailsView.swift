//
//  MatchDetailsView.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct MatchDetailsView: View {
    var event: SportEvent
    
    var body: some View {
        NavigationView {
            Text("Hello Idiot!")
        }
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(event: SportEvent.loadSampleEvent()!)
    }
}
