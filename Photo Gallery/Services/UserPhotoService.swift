//
//  UserPhotoService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation
import Combine

class UserPhotoService {
    @Published var photos: [Photo] = []
    private var cancellable: AnyCancellable? = nil
    private let username: String
    var page: Int = 1
    var userProfileContent: UserProfileContent = .photos
    
    init(username: String) {
        self.username = username
        downloadPhotos()
    }
    
    func downloadPhotos() {
        var url: URL? = nil
        
        switch userProfileContent {
        case .photos:
            url = URL(string: ApiURLs.ListAPhotosOfUser(username: username, page: page))
        case .likes:
            url = URL(string: ApiURLs.ListAUsersLikedPhotos(username: username, page: page))
        case .collections:
            url = URL(string: "")
        }
        
        guard let url = url else {
            return
        }
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
                self?.cancellable?.cancel()
            })
        
    }
}
