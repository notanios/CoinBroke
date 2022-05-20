//
//  ContentView.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import SwiftUI

struct CryptoView: View {
    var viewModel: CryptoViewModel
    
    init(viewModel: CryptoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ListOfCoins
    }
}

extension CryptoView {
    var ListOfCoins: some View {
        ForEach(viewModel.coinModels) { model in
            CoinRow(viewModel: model)
        }
    }
}
