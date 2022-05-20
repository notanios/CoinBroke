//
//  AsyncImage.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import SwiftUI
import Combine

struct AsyncImage: View {
  @ObservedObject var imageLoader:ImageLoader
  @State var image: UIImage = UIImage()
  var fallbackImage: UIImage?

  init(withURL url: String?, fallbackImage: UIImage?) {
    self.fallbackImage = fallbackImage
    imageLoader = ImageLoader(urlString:url)
  }

  var body: some View {
        
      Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width:32, height:32)
          .onReceive(imageLoader.didChange) { data in
            self.image = (UIImage(data: data) ?? self.fallbackImage) ?? UIImage(systemName: "photo.circle.fill")!
          }
    }
}
