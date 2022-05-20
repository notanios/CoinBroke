//
//  CryptoViewModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI

class CryptoViewModel: CryptoDelegate {
    var crypto: Crypto?
    var coinModels: [CoinRowModel] = []
    
    init() {
        self.crypto = Crypto(delegate: self)
        
        if let crypto = self.crypto {
            let coins = crypto.getAllCoins()
            
            self.coinModels = coins.map({ coin in
                CoinRowModel(coin: coin)
            })
        }
    }
    
    
    //Crypto Delegate
    
    func cryptoAPIDidConnect() {
    }
    
    func cryptoAPIDidUpdateCoin(_ coin: Coin) {
    }
    
    func cryptoAPIDidDisconnect() {
    }
}
