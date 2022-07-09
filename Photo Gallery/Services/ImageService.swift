//
//  PhotoImageService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation
import Combine
import SwiftUI

enum ImageOptions {
    case photo, profile
}

class ImageService {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable? = nil
    private let photo: Photo
    private let options: ImageOptions
    
    private let cacheManager: CacheManager = CacheManager.shared
    
    init(photo: Photo, options: ImageOptions) {
        self.photo = photo
        self.options = options
        getImage()
        //print("INIT service")
    }
    
    deinit {
        //print("DEINIT service")
    }
    
    private func getImage() {
        var photoId: String? = ""
        
        switch options {
        case .photo:
            photoId = photo.id
        case .profile:
            photoId = photo.user?.id
        }
        
        if let photoId = photoId, let cachedImage = cacheManager.getImage(id: photoId) {
            print("RETRIEVED: \(photoId)")
            self.image = cachedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        
        var urlString: String? = ""
        var photoId: String? = ""
        
        switch options {
        case .photo:
            urlString = photo.urls?.small
            photoId = photo.id
        case .profile:
            urlString = photo.user?.profileImage?.large
            photoId = photo.user?.id
        }
        
        guard let urlString = urlString else {return}
        
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
                if let photoId = photoId, let image = returnedImage {
                    print("DOWNLOADED: \(photoId)")
                    self?.cacheManager.addImage(image: image, id: photoId)
                }
                self?.cancellable?.cancel()
            })
    }
}
