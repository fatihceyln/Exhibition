//
//  UserProfileImageService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation
import Combine
import SwiftUI

class UserProfileImageService {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable? = nil
    private let user: User
    
    private let cacheManager: CacheManager = CacheManager.shared
    
    init(user: User) {
        self.user = user
        getImage()
    }
    
    private func getImage() {
        if let id = user.id, let cachedImage = cacheManager.getImage(id: id) {
            print("RETRIEVED (PROFILE): \(id)")
            self.image = cachedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let urlString = user.profileImage?.large else {return}
        
        guard let url = URL(string: urlString) else {return}
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                
                if let id = self?.user.id, let image = returnedImage {
                    self?.cacheManager.addImage(image: image, id: id)
                    print("DOWNLOADED (PROFILE): \(id)")
                }
                self?.cancellable?.cancel()
            })
    }
}
