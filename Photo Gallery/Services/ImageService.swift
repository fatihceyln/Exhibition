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
    
    init(photo: Photo, options: ImageOptions) {
        self.photo = photo
        self.options = options
        downloadImage()
        print("INIT service")
    }
    
    deinit {
        print("DEINIT service")
    }
    
    private func downloadImage() {
        
        var urlString: String? = ""
        
        switch options {
        case .photo:
            urlString = photo.urls?.small
        case .profile:
            urlString = photo.user?.profileImage?.large
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
                self?.cancellable?.cancel()
            })
    }
}
