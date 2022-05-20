//
//  CryptoViewModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation

class CryptoViewModel {
    private var coinFetcher: CoinFetchable
    var coinModels: [CoinRowViewModel] = []
    
    init(coinFetcher: CoinFetchable) {
        self.coinFetcher = coinFetcher
        self.getAllTheCoins()
    }
    
    private func getAllTheCoins() {
        let coins = self.coinFetcher.getAllCoins()
        let models = coins.map { coin in
          return CoinRowViewModel(coin: coin)
        }
        
        self.coinModels = models
    }
}
