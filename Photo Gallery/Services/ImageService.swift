//
//  PhotoImageService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation
import Combine
import SwiftUI

class ImageService {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable? = nil
    private let photo: Photo
    
    private let cacheManager: CacheManager = CacheManager.shared
    
    init(photo: Photo) {
        self.photo = photo
        getImage()
        //print("INIT service")
    }
    
    deinit {
        //print("DEINIT service")
    }
    
    private func getImage() {
        
        if let id = photo.id, let cachedImage = cacheManager.getImage(id: id) {
            print("RETRIEVED: \(id)")
            self.image = cachedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        
        guard let urlString = photo.urls?.small else {return}
        
        guard let url = URL(string: urlString) else {return}
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("succesfull 1")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                if let id = self?.photo.id, let image = returnedImage {
                    print("DOWNLOADED: \(id)")
                    self?.cacheManager.addImage(image: image, id: id)
                }
                self?.cancellable?.cancel()
            })
    }
}
