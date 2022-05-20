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
    private var storage: DataPersistable?
    @Published var coinModels: [CoinRowViewModel] = []
    
    init(coinFetcher: CoinFetchable) {
        self.coinFetcher = coinFetcher
        self.storage = RealmPersistance()
        self.getAllTheCoins()
        self.coinFetcher.startFetching { coin in
            self.save(coin: coin)
            self.updateViewModels(coin: coin)
        }
    }
    
    private func save(coin: Coin) {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        guard let storage = self.storage else { return }
        let storedCoin = StoredCoin()
          storedCoin.name = coin.name
          storedCoin.imageUrl = coin.imageUrl
          storedCoin.price = coin.price
          storedCoin.code = coin.code
        _ = storage.save(coin: storedCoin)
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
