//
//  PhotoService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import Foundation
import Combine

class PhotoService {
    @Published var photos: [Photo] = []
    private var cancellable: AnyCancellable? = nil
    var page: Int = 1
    private let topicEnum: TopicEnum?
    private let userName: String?
    var userProfileContent: UserProfileContent = .photos
    
    init(topicEnum: TopicEnum? = nil, userName: String? = nil) {
        self.topicEnum = topicEnum
        self.userName = userName
        downloadPhotos()
    }
    
    func downloadPhotos() {
        var url: URL? = nil
        
        if let topicEnum = topicEnum {
            url = URL(string: ApiURLs.topicPhoto(topic: topicEnum, page: page))
        } else if let userName = userName {
            switch userProfileContent {
            case .photos:
                url = URL(string: ApiURLs.ListAPhotosOfUser(username: userName, page: page))
            case .likes:
                url = URL(string: ApiURLs.ListAUsersLikedPhotos(username: userName, page: page))
            case .collections:
                url = URL(string: "")
            }
        } else {
            url = URL(string: ApiURLs.editorial(byPage: page))
        }
        
        guard let url = url else {return}
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] downloadedPhotos in
                self?.photos = downloadedPhotos
                self?.cancellable?.cancel()
            })
    }
}
