//
//  CryptoViewModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI

class CryptoViewModel: ObservableObject, Identifiable {
    
    private var coinFetcher: CoinFetchable
    @Published var coinModels: [CoinRowViewModel] = []
    
    init(coinFetcher: CoinFetchable) {
        self.coinFetcher = coinFetcher
        self.getAllTheCoins()
        self.coinFetcher.startFetching { coin in
            self.updateViewModels(coin: coin)
        }
    }
    
    private func updateViewModels(coin: Coin) {
        if let tableModel = self.coinModels.first(where: { sourceModel in
          sourceModel.code == coin.code
        }) {
          tableModel.update(with: coin)
        }
    }
    
    private func getAllTheCoins() {
        let coins = self.coinFetcher.getAllCoins()
        let models = coins.map { coin in
          return CoinRowViewModel(coin: coin)
        }
        
        self.coinModels = models
    }
}
