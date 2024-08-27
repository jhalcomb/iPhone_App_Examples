//
//  CurrencyIcon.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/25/24.
//

import SwiftUI

struct CurrencyIcon: View {
    
    // Properties (paramaters)
    let currencyImage: ImageResource
    let currencyName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Currency Image
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            // Currency Name
            Text(currencyName)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity) //.infinity streaches to the edge of the parent view
                .background(.brown.opacity(0.75)) // Background needs to come last. Modifier order matters.
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrencyIcon(currencyImage: .goldpiece, currencyName: "Gold Piece")
}
