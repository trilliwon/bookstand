//
//  ImageService.swift
//  bookstand
//
//  Created by Won on 2019/09/26.
//  Copyright © 2019 Won. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

class ImageLoaderCache {
    
    static let shared = ImageLoaderCache()
    
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(path: String) -> ImageLoader {
        let key = NSString(string: "\(path)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageLoader(path: path)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}

final class ImageLoader: ObservableObject {
    let path: String
    
    var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers.Sequence<[UIImage?], Never>(sequence: []).eraseToAnyPublisher()
    
    @Published var image: UIImage?
    
    var cancellable: AnyCancellable?
    
    init(path: String) {
        self.path = path
        objectWillChange = $image
            .handleEvents(receiveSubscription: { [weak self] sub in
                self?.loadImage()
            }, receiveCancel: { [weak self] in
                self?.cancellable?.cancel()
            })
            .eraseToAnyPublisher()
    }
    
    private func loadImage() {
        guard image == nil, let url = URL(string: path) else {
            return
        }
        cancellable = fetchImage(for: url)
            .receive(on: DispatchQueue.main)
            .assign(to: \ImageLoader.image, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchImage(for url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map({ $0.data })
            .receive(on: RunLoop.main)
            .map({ UIImage(data: $0) })
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
