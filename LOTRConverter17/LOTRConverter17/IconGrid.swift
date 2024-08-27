//
//  IconGrid.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/26/24.
//

import SwiftUI

struct IconGrid: View {
    
    @Binding var selectedCurrency: Currency // Use the currency from the binding
    
    
    var body: some View {

        // Define our grid with 3 columns. Any more columns will be on a new line.
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases) { c in
                if self.selectedCurrency == c {
                    CurrencyIcon(currencyImage: c.image, currencyName: c.name)
                    .shadow(color: .black, radius: 10)
                    .overlay { // overlay puts something infront
                        RoundedRectangle(cornerRadius: 25) // set cornerRadius to the same as the icon
                            .stroke(lineWidth: 3) // turn the RR into just a border
                            .opacity(0.5)
                }

                    } else {
                        CurrencyIcon(currencyImage: c.image, currencyName: c.name)
                            // This modifier makes it clickable
                            .onTapGesture {
                                // update the selectedCurrency to what we clicked
                                self.selectedCurrency = c
                            }
                    }
            }
            
            

        }
    }
}

#Preview {
    IconGrid(selectedCurrency: .constant(.silverPiece))
}
