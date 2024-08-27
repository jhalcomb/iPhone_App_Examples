//
//  ContentView.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/24/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State var showExchangeInfo = false // Track showing the info screen
    // @State tells the content view that this variable can change the state of the view
    
    @State var showSelectCurrency = false // Track showing the selectCurrency screen
    
    @State var leftAmoutTextfield = ""
    @State var rightAmoutTextfield = ""
    
    // Track the selected currency objects so we can update the image and text
    // These are from the Currency Model/Scope
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    // @FocusState is a special boolean property to track where we are focused
    // We will track the text fields and make decisions based on if they are active or not
    // This is to fix the issue of each text field trying to update each other
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    
    var body: some View {
        ZStack {
            //Background Image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                // Prancing Pony Image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency Exchange Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Currency Conversion Section
                HStack{
                    //Let Conversion Section
                    VStack{
                        // Currency
                        HStack{
                            // Currency Image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            //Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        
                        // Textfield
                        TextField("Amount", text: $leftAmoutTextfield)
                            // The $ makes this a 'binding' and allows the user to change the leftAmountTextfield variable as they type.
                            .textFieldStyle(.roundedBorder)
                            // This onChange will observe the leftAmountTextfield and respond when it is modified.
                            .focused($leftTyping) // updates the leftTyping boolean when this field is active
                            .keyboardType(.decimalPad)
                            
                    }
                    
                    // Equal Sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right Conversion Section
                    VStack{
                        // Currency
                        HStack{
                            // Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            //Currency Image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        // Textfield
                        TextField("Amount", text: $rightAmoutTextfield)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            // This onChange will observe the rightAmountTextfield and respond when it is modified.
                            .focused($rightTyping) // updates the rightTyping boolean when this field is active
                            .keyboardType(.decimalPad)
                            
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                // Info Button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    
                }
                
            }

        } // Close ZStack
        .onChange(of: leftAmoutTextfield) {
            // We update the right field to the new conversion value
            // Only update when this field is active
            if leftTyping {
                rightAmoutTextfield = leftCurrency.convert(leftAmoutTextfield, to: rightCurrency)
            }
            
        }
        .onChange(of: rightAmoutTextfield) {
            // We update the left field to the new conversion value
            // Only update when this field is active
            if rightTyping {
                leftAmoutTextfield = rightCurrency.convert(rightAmoutTextfield, to: leftCurrency)
            }
            
        }

        // Convert textfield values if we change the currency from the other screen.
        .onChange(of: leftCurrency) {
            leftAmoutTextfield = rightCurrency.convert(rightAmoutTextfield, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmoutTextfield = leftCurrency.convert(leftAmoutTextfield, to: rightCurrency)
        }

        // Putting the sheet tracking after the ZStack just to keep it at the bottom
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(TopCurrency: $leftCurrency, BottomCurrency: $rightCurrency)
        }
        // Tasks to run when the screen appears
        .task {
            // Using try will conceal errors if any occur
            try? Tips.configure()
        }
    }
}
    
#Preview {
    ContentView()
}
