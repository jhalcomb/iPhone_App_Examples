//
//  CurrencyTip.swift
//  LOTRConverter17
//
//  Created by Halcomb on 8/26/24.
//

import Foundation
import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    // The ? means it is optional to define.
    // If you set Text, then it uses that value, if you don't define it at all, it is nil
    var message: Text? = Text("You can tap the left or right currency to bring up the Select Currency screen.")
    
    
}
