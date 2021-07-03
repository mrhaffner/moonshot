//
//  AstronautView.swift
//  Moonshot
//
//  Created by Matt Haffner on 6/30/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionsIn: [Mission]
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missionsIn, id: \.displayName) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            if mission.crew.contains(where: { $0.name == astronaut.id}){
                matches.append(mission)
            }
        }
        
        self.missionsIn = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
        
    }
}
