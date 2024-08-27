//
//  CurrencyModel.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/25/24.
//
import SwiftUI

// Currency Model (Enum type)
// values are all based off of the Gold Piece being 1.
// Adding CaseIterable turns this into an Array/List - This way we can just loop through this to display each one.
// Adding Identifiable means that you can uniqely identify each case.
enum Currency: Double, CaseIterable, Identifiable {
    var id: Currency {self} // This is needed to make it Identifiable, we need an 'id' field and set it to something unique.
    
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    // This is a Computed Property
    var image: ImageResource {
        // Set the image that matches the case that is instantiated
        // Using 'switch' instead of 'if/elif'
        switch self {
        case .copperPenny: // This value refers to the top currency cases (if that matches self)
                .copperpenny // This value refers to the Image resourse (what is set as the image)
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPiece:
                .goldpiece
        case .goldPenny:
                .goldpenny
        }
    }

    // Another Computed Property, similar to above
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    // This is a function
    // These paramaters have 2 names. One is for USING the code, the other is for WRITING it. This is optional but can make the code more 'readable'.
    func convert(_ amountString: String, to currency: Currency) -> String {
        // Convert the String to a double, protect with guard.
        guard let doubleAmount = Double(amountString) else {
            return "" // Return nothing (don't do anything) if invalid conversion.
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        // Return a string to put in the opposite Amount field. Format to 2 decimal places.
        return String(format: "%.2f", convertedAmount)
        
    }
    
    
    
}
