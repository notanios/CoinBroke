//
//  CoinRowModel.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI

class CoinRowViewModel: Identifiable, ObservableObject {
    enum Dynamics {
      case growing
      case declining
      case stable
    }
    
    @Published private var coin: Coin
    
    private(set) var dynamics: Dynamics
    private(set) var maxPrice: Double
    private(set) var minPrice: Double
    
    init(coin: Coin) {
        self.coin = coin
        self.minPrice = coin.price
        self.maxPrice = coin.price
        self.dynamics = .stable
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
    
    var imageUrl: String? {
        coin.imageUrl
    }
    
    var price: String {
        String(format: "$ %.02f", coin.price)
    }
    
    var minDisplayPrice: String {
        String(format: "$ %.02f", minPrice)
    }
    
    var maxDisplayPrice: String {
        String(format: "$ %.02f", maxPrice)
    }
    
    func update(with coin: Coin) {
      DispatchQueue.main.async {
        self.dynamics = coin.price < self.coin.price ? .declining : coin.price > self.coin.price ? .growing : .stable
          
        self.coin = coin
          
        self.maxPrice = [self.maxPrice, coin.price].max() ?? coin.price
        self.minPrice = [self.minPrice, coin.price].min() ?? coin.price
      }
    }
}
