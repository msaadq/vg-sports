//
//  NavigationButton.swift
//  VGSports
//
//  Created by Saad Qureshi on 16/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct NavigationButton : View {
    let text: String
    var body: some View {
        HStack {
            Text(text.capitalized)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.leading, 10)
                .padding([.top, .bottom], 5)
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 5, height: 10)
                .foregroundColor(.primary)
                .padding(.trailing, 10)
            
            }
            .background(
                Rectangle()
                    .foregroundColor(.cellColor)
                    .cornerRadius(12)
        )
            .padding(.bottom, 4)
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(text: "Hello")
        .environment(\.colorScheme, .light)
        
    }
}
