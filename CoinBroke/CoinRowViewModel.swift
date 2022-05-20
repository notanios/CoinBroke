//
//  CoinRowModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI

class CoinRowViewModel: Identifiable {
    var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var id: String {
        self.code
    }
    
    var name: String {
        coin.name
    }
    
    var code: String {
        coin.code
    }
    
    var price: String {
        String(format: "$ %.02f", coin.price)
    }
    
    var minPrice: String {
        "% 666.66"
    }
    
    var maxPrice: String {
        "% 666.66"
    }
}
