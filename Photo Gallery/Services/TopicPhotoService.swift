//
//  TopicPhotoService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import Foundation
import Combine

class TopicPhotoService {
    @Published var photos: [Photo] = []
    private let topicEnum: TopicEnum
    private var cancellable: AnyCancellable? = nil
    private var page: Int = 1
    
    init(topicEnum: TopicEnum) {
        self.topicEnum = topicEnum
        downloadTopicPhoto()
    }
    
    func downloadTopicPhoto() {
        guard let url = URL(string: ApiURLs.topicPhoto(topic: topicEnum, page: page)) else {return}
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink { _ in
                
            } receiveValue: { [weak self] returnedTopicPhotos in
                self?.photos = returnedTopicPhotos
                self?.cancellable?.cancel()
            }

    }
}
