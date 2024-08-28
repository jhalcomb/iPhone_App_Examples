//
//  Predators.swift
//  JP Apex Preditors 17
//
//  Created by Halcomb on 8/26/24.
//

// This is our 'middle' area where we take the data and PREPARE it for the view.

import Foundation

class Predators{
    
    // Store the data once decoded - This is a list of all dinosaurs.
    var allApexPredators: [ApexPreditorModel] = [] // This var never gets modified. Used to reset the filter with everything.
    var apexPredators: [ApexPreditorModel] = [] // This var gets modified by sort and filter
    
    // Run the decodeApexPreditorData as soon as this class is initialized.
    init() {
        decodeApexPreditorData()
    }
    
    func decodeApexPreditorData() {
        // Create a url variable to the JSON file if it exists.
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            // do/try/catch is the python try/except
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // This tells the decoding process that the JSON is in snakeCase when there are multiple words.
                // Putting .self is how Swift passes the instantiated object rather than just the model. That's just the way Swift does it.
                allApexPredators = try decoder.decode([ApexPreditorModel].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    // Takes in a search character(s) and returns a list of predators that match the given character(s)
    func search(for searchTerm: String) -> [ApexPreditorModel] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    // Sort the Dinosaurs
    // if alphabetical is true then it sort alphabetical, otherwise it sorts by movie order which is how it is structured in the JSON by default.
    func sort(by alphabetical: Bool) {
        // sort is an 'in place' function - meaning it simply re-arranges the collection rather than adding/removing from it.
        apexPredators.sort {
            // The .sort needs more than 1 property in order to make a comparison
            predator1, predator2 in
            if alphabetical {
                // sort on the name field
                predator1.name < predator2.name
            } else {
                // sort on the id field, lowest first
                predator1.id < predator2.id
            }
        }
    }
    
    
    func filter(by type: PredatorType) {
        // filter is not 'in place' - meaning it creates a temp list based on the condition and then we update our list var with the temp list.
        if type == .all {
            // since there is no type of 'all' in the JSON, we just need to reset the apexPredators list to everything.
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { // we base our filter on the allApexPredators which contains everything. This is how the filter gets reset each time.
                predator in
                predator.type == type
            }
        }
        
    }
}
