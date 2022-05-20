//
//  CryptoUpdateSource.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import CryptoAPI


protocol CoinFetchable {
  typealias CoinUpdateHandler = ((Coin) -> Void)
  
  func getAllCoins() -> [Coin]
  func startFetching(handler: CoinUpdateHandler?)
  func stopFetching()
}

class CoinFetcher: CoinFetchable, CryptoDelegate {
  typealias UpdateStatusHandler = ((_ fetching: Bool) -> Void)
  
  private var handler: CoinUpdateHandler?
  private var statusHadler: UpdateStatusHandler?
  private var crypto: Crypto?
  private var fetching: Bool = false {
    didSet {
      self.statusHadler?(self.fetching)
    }
  }
  
  init(with crypto: Crypto?, statusHandler: UpdateStatusHandler?, and updateHandler: CoinUpdateHandler?) {
    self.crypto = crypto ?? Crypto(delegate: self)
    self.handler = updateHandler
    self.statusHadler = statusHandler
  }
  
  
  // Fetchable Methods
  func getAllCoins() -> [Coin] {
    self.crypto?.getAllCoins() ?? []
  }
  
  func startFetching(handler: CoinUpdateHandler?) {
    if let handler = handler {
      self.handler = handler
    }
    self.connect(with: .now())
  }
  
  func stopFetching() {
    self.crypto?.disconnect()
  }
  
  
  // Custom Methods
  private func connect(with time: DispatchTime) {
      DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
          switch self?.crypto?.connect() {
          case .success(_): ()
          case .failure(let error):
              if let connectLaterError = error as? CryptoError, case let .connectAfter(date: date) = connectLaterError {
                  let secs = Int(date.timeIntervalSinceNow)
                  self?.connect(with: .now() + .seconds(secs))
              }
          default: ()
          }
      }
  }
  
   //Crypto Delegate
  
  func cryptoAPIDidConnect() {
    self.fetching = true
  }
  
  func cryptoAPIDidUpdateCoin(_ coin: Coin) {
    self.handler?(coin)
  }
  
  func cryptoAPIDidDisconnect() {
    self.fetching = true
    connect(with: .now())
  }
}
