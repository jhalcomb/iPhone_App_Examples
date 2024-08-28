//
//  ContentView.swift
//  JP Apex Preditors 17
//
//  Created by Halcomb on 8/26/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    
    // Store searh field text
    @State var searchText = ""
    @State var alphabetical = false // sorting tracking
    @State var currentFilterSelection = PredatorType.all // store the current filter, default to all
    
    // Computed Property to help with filtering and sorting
    var filteredDinos: [ApexPreditorModel] {
        predators.filter(by: currentFilterSelection) // run the filter
        predators.sort(by: alphabetical) // run the sort
        return predators.search(for: searchText)
    }
    
    var body: some View {
        
        // NavigationStack is a stack of views
        NavigationStack {
            // List works like a ForEach with other features built in like Lazyness and Scrolling
            // We make each item in the list it's own full-screen view when clicked.
            List(filteredDinos) { predator in
                // NavigationLink makes the views clickable
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    HStack {
                        // Dinosour Image
                        Image(predator.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        // alignment .leading pushes everything to the left
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                            
                        }
                    }
                }
            }
            // This goes on the List (the root view)
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar { // a toolbar comes with the navigation stack
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        // This is written with the 'Ternary' method
                        // You could also write this with if/else
                        // If alphabetical is true, show the film label, else show the Aa (textformat) label
                        Image(systemName: alphabetical ?
                              "film" : "textformat")
                        .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        // Picker has built-in select and tap functionality
                        Picker("Filter", selection: $currentFilterSelection.animation()) {
                            ForEach(PredatorType.allCases) {
                                type in
                                Label(type.rawValue.capitalized,
                                      systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
