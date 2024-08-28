//
//  ApexPreditorModel.swift
//  JP Apex Preditors 17
//
//  Created by Halcomb on 8/26/24.
//

import Foundation
import SwiftUI
import MapKit

// This model is a struct rather than an enum becuase we are operating under the assumption
// that we have an unknown ammount of cases. (the JSON file may be updated at some point with new dinosaurs)
// The idea with this model is to make it match the JSON file so we can convert or 'decode' the JSON into instances of this model
// Make sure the names match the JSON keys exactly. Use camelCase in this model. We will tell the decode process to convert the JSON snake_case to our camelCase.
struct ApexPreditorModel: Decodable, Identifiable { // Decodable makes this available for the JSON, Identifiable makes us able to loop through it.
    let id: Int
    let name: String
    let type: PredatorType // Using a custom type that is a String
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    // Computed Property
    var imageName: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    // Use MapKit resources to create a location computed property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
}


// This enum is to help us color the types on the main screen
// Don't nest this in the above model so we can use it from another module easier.
enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all // need this for the filtering
    case land
    case air
    case sea
    
    var id: PredatorType { // This lets us comply with Identifiable
        self
    }
    
    // set the bg color for showing the predator type
    var background: Color {
        switch self {
        case .all:
            .black
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        }
    }
    
    // set the icon to show on the filter menu
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }

}
