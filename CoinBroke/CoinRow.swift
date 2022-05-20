//
//  CoinRow.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import SwiftUI

struct CoinRow: View {
    @ObservedObject private var viewModel: CoinRowViewModel
    @State private var animationStatus: AnimationStatus = .none
    
    enum AnimationStatus {
      case none
      case increased
      case decreased

      var color: Color {
        switch self {
        case .none:
            return .white
        case .increased:
            return .green
        case .decreased:
            return .red
        }
      }
    }
    
    init(viewModel: CoinRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(withURL: viewModel.imageUrl, fallbackImage: nil)
                Text(viewModel.name)
                    .font(.system(size: 16))
                Text(viewModel.code)
                    .font(.system(size: 16))
                Spacer()
                Text("Price: \(viewModel.price)")
                    .padding(5)
                    .font(.system(size: 22))
                    .background(animationStatus.color)
                    .cornerRadius(5)
                    .animation(.spring(), value: animationStatus)
                    .onChange(of: viewModel.dynamics) { dynamics in
                      switch dynamics {
                      case .growing:
                        animationStatus = .increased
                      case .declining:
                        animationStatus = .decreased
                      case .stable:
                        animationStatus = .none
                      }
                      
                      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        animationStatus = .none
                      }
                    }
            }
            
            HStack {
                Text("min: \(viewModel.minDisplayPrice)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Text("max: \(viewModel.maxDisplayPrice)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.leading, 8)
        }
    }
}
