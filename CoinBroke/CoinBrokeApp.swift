//
//  CoinBrokeApp.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import SwiftUI

@main
struct CoinBrokeApp: App {
    var body: some Scene {
        WindowGroup {
            let fetcher = CoinFetcher(with: nil, statusHandler: nil, and: nil)
            let viewModel = CryptoViewModel(coinFetcher: fetcher)
            CryptoView(viewModel: viewModel)
        }
    }
}
