//
//  MatchDetailsView.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import SwiftUI

struct MatchDetailsView: View {
    @ObservedObject var vm: MatchDetailsVM
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)

            VStack(spacing: 50) {
                HStack(spacing: 10) {
                    GameStatusDisplay(status: vm.eventDetails.status.type)
                    if vm.eventDetails.status.type == .notStarted {
                        Text("Starts \(vm.eventDetails.displayStartTimeWithDate())")
                            .font(.headline)
                            .bold()
                    } else {
                        Text("Started \(vm.eventDetails.displayStartTimeWithDate())")
                            .font(.headline)
                            .bold()
                    }
                }
                
                HStack {
                    EventTeamRep(logo: vm.eventDetails.homeTeam.logo, teamName: vm.eventDetails.homeTeam.name, isWinner: vm.eventDetails.homeTeam.isWinner)
                    VStack(spacing: 26) {
                        HStack(alignment: .center) {
                            Text("\(vm.eventDetails.result.runningScore.home)")
                            Text("-")
                            Text("\(vm.eventDetails.result.runningScore.away)")
                        }
                        .font(.largeTitle)
                        .foregroundColor(Color(UIColor.label))
                        .shadow(radius: 10)
                    }
                    EventTeamRep(logo: vm.eventDetails.awayTeam.logo, teamName: vm.eventDetails.awayTeam.name, isWinner: vm.eventDetails.awayTeam.isWinner)
                }
                
                if !vm.connectionOffline {
                    VStack(spacing: 30) {
                        HStack(alignment: .bottom, spacing: 0) {
                            Image("VenueIcon")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .shadow(radius: 10)
                            Text(vm.eventDetails.venue?.getVenue() ?? "Unknown location")
                                .font(.headline)
                                .padding(.leading, 15)
                                .padding(.top, 5)
                        }
                        .padding(.top)
                        .padding(.leading)
                        
                        Button(action: {
                            let url = "comgooglemaps://?daddr=\(self.vm.eventDetails.venue!.getVenue().replacingOccurrences(of: " ", with: "+").replaceSpecialCharacters() ?? "Unknown location")"
                            
                            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                              UIApplication.shared.openURL(URL(string: url)!
                                )
                            } else {
                              print("Can't use comgooglemaps://");
                            }
                            
                        }) {
                            NavigationButton(text: "Get Directions ")
                        }
                    }
                }
            }
            .offset(CGSize(width: 0, height: -80))
            .padding()
            .navigationBarTitle(Text("Sport Event"))
            .onAppear() {
                self.vm.loadEventDetails()
            }
            .onDisappear {
                self.vm.cancellable?.cancel()
            }
        }
        
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(vm: MatchDetailsVM(event: SportEvent.loadSampleEvent()!))
    }
}
