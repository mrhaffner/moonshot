//
//  ContentView.swift
//  Moonshot
//
//  Created by Matt Haffner on 6/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingDates = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Group {
                            if showingDates {
                                Text(mission.formattedLaunchDate)
                            } else {
                                Text(mission.formattedNames)
                            }
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showingDates ? "Show Names" : "Show Dates" , action: { showingDates.toggle() }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
