//
//  Select Currency.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/25/24.
//

import SwiftUI

struct SelectCurrency: View {
    
    @Environment(\.dismiss) var dismiss // For page dismissal
    
    // Track the selected currency
    // The actual values will be pulled from the ContentView
    @Binding var TopCurrency: Currency
    @Binding var BottomCurrency: Currency
    
    var body: some View {
        ZStack{
            // Background Image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                // Text
                Text("Select the Currency you are starting with:")
                    .fontWeight(.bold)
                    
                
                // Currency Icons
                IconGrid(selectedCurrency: $TopCurrency)
                
                
                
                // Text
                Text("Select the Currency you would like to convert to:")
                    .fontWeight(.bold)

                
                // Currency Icons
                IconGrid(selectedCurrency: $BottomCurrency)

                
                // Done Button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)

                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    // To preview, Bindings take a .constant
    SelectCurrency(TopCurrency: .constant(.copperPenny), BottomCurrency: .constant(.silverPiece))
}
