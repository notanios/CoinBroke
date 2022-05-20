//
//  CoinRow.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import SwiftUI

struct CoinRow: View {
    var viewModel: CoinRowModel
    
    init(viewModel: CoinRowModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "bitcoinsign.circle")
                Text(viewModel.name)
                Text(viewModel.code)
                Text("Price: \(viewModel.price)")
            }
            
            HStack {
                Text("min: \(viewModel.minPrice)")
                Text("max: \(viewModel.maxPrice)")
            }
        }
    }
}
