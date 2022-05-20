//
//  CoinRowModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI

class CoinRowModel: Identifiable {
    var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var id: String {
        self.code
    }
    
    var name: String {
        "Name"
    }
    
    var code: String {
        "Code"
    }
    
    var price: String {
        "$ 666.66"
    }
    
    var minPrice: String {
        "% 666.66"
    }
    
    var maxPrice: String {
        "% 666.66"
    }
}
