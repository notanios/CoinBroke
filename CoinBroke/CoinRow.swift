//
//  CoinRow.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import SwiftUI

struct CoinRow: View {
    var viewModel: CoinRowViewModel
    
    init(viewModel: CoinRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "bitcoinsign.circle")
                Text(viewModel.name)
                    .font(.system(size: 16))
                Text(viewModel.code)
                    .font(.system(size: 16))
                Spacer()
                Text("Price: \(viewModel.price)")
                    .padding(5)
                    .cornerRadius(5)
                    .font(.system(size: 22))
                    .background(.green)
            }
            
            HStack {
                Text("min: \(viewModel.minPrice)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Text("max: \(viewModel.maxPrice)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.leading, 8)
        }
    }
}
