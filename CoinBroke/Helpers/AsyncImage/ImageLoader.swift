//
//  ImageLoader.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString: String?) {
      guard let urlString = urlString else { return }
      guard let url = URL(string: urlString) else { return }
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
          guard let data = data else { return }
          DispatchQueue.main.async {
              self.data = data
          }
      }
      task.resume()
    }
}
