//
//  PredatorMap.swift
//  JP Apex Preditors 17
//
//  Created by Halcomb on 8/27/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    
    let predators = Predators() // Gives us access to all predators to put them all on the map
    
    @State var position: MapCameraPosition
    @State var satelliteView = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) {
                predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satelliteView ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        // This overlay is for the bottom right button that switches to Satellite view
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelliteView.toggle()
            } label: {
                Image(systemName: satelliteView ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic) // Fix the toolbar bug
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}
