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
    private var page: Int = 1
    private var topicEnum: TopicEnum?
    
    init(topicEnum: TopicEnum? = nil) {
        self.topicEnum = topicEnum
        downloadPhotos()
    }
    
    func downloadPhotos() {
        var url: URL? = nil
        
        if let topicEnum = topicEnum {
            url = URL(string: ApiURLs.topicPhoto(topic: topicEnum, page: page))
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
