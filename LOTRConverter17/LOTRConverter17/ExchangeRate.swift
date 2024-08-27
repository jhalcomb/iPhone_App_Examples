//
//  ExchangeRate.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/25/24.
//

import SwiftUI

struct ExchangeRate: View {
    
    // Paramaters
    // These don't need the @State wrapper becuase they don't change after instantiation
    // Also, no initial values are being set (aka: all 3 are required)
    let leftImage: ImageResource
    let mytext: String
    let rightImage: ImageResource
    
    
    var body: some View {
        HStack{
            // Left Currency Image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Exchange Rate Text
            Text(mytext)
            
            // Right Currency Image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, mytext: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
}
