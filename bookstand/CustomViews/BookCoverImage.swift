//
//  BookCoverImage.swift
//  bookstand
//
//  Created by Won on 2019/09/26.
//  Copyright © 2019 Won. All rights reserved.
//

import SwiftUI

struct BookCoverImage: View {

    @ObservedObject var imageLoader: ImageLoader
    @State var isImageLoaded = false

    var body: some View {
        ZStack(alignment: .center) {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .scaleEffect(self.isImageLoaded ? 1 : 0.6)
                    .animation(.spring())
                    .onAppear{
                        self.isImageLoaded = true
                    }
            } else {
                Rectangle()
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BookCoverImage_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverImage(
            imageLoader:
                ImageLoader(path: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1590611%3Ftimestamp%3D20190131033601")
        )
    }
}
