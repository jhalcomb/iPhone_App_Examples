//
//  PredatorDetail.swift
//  JP Apex Preditors 17
//
//  Created by Halcomb on 8/27/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    let predator: ApexPreditorModel
    
    @State var position: MapCameraPosition
    
    var body: some View {
        // Geometery reader lets us use its size for child objects - making child object relative to the
        // parent rather than hard-coding the child values.
        GeometryReader {geo in
            // ScrollView is like a ZStack, but it starts at the top, not the center.
            ScrollView {
                ZStack (alignment: .bottomTrailing) { // alight as low and right
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            // This creates a gradient
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.80),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // Dino Image
                    Image(predator.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                // Dino Name
                // Wrapping in a VStack so we can use alignment
                VStack (alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    
                    // Current Location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                    } label: {
                        // Position is the POV you want to look at it from
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            // Remove the default title
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        // This overlay creates the greater than sign to indicate this is clickable
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        // This overlay creates the top left 'Current Location' text.
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        // This curves the corners of the whole map
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    
                    
                    // Movies Appears in
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top)
                    // The id: \.self tells the ForEach to use the literal string value as the ID
                    // This is making an 'identifiable' inline since we can't modify the built-in
                    // Stirng object itself. We tell the ForEach to use the literal string since it is unique already
                    ForEach(predator.movies, id: \.self) {movie in
                        // Ust Cmd + Ctrl + Space to insert an emoji as a string
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie Moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to Webpage
                        Text("Read More:")
                            .font(.caption)
                        Link(predator.link, destination:
                                // URLs are considered 'optional' by default and require them to be used in
                                // a certain way. Using ! relaxes these requirements since we are sure we
                                // have valid URLs to begin with. More on this later.
                                URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                // This helps push the content to the left by expanding the frame.
                .frame(width: geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        // Fix the toolbar bug when the map is on the page
        .toolbarBackground(.automatic)
    }
}

#Preview {
    // Using Navigation stack just to mimick running from ContentView which IS in a NavigationStack
    NavigationStack{
        PredatorDetail(predator: Predators().apexPredators[10], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
