//
//  TopicViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import Foundation
import Combine
import SwiftUI

class TopicViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var topic: Topic? = nil
    let topicPhotoService: TopicPhotoService
    let topicService: TopicService
    private var cancellablePhoto: AnyCancellable? = nil
    private var cancellableTopic: AnyCancellable? = nil
    
    init(topicEnum: TopicEnum, id: String) {
        self.topicPhotoService = TopicPhotoService(topicEnum: topicEnum)
        self.topicService = TopicService(id: id)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellablePhoto = topicPhotoService.$photos
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPhotos in
                for item in returnedPhotos {
                    if self?.photos.allSatisfy({$0.id != item.id}) == true {
                        self?.photos.append(item)
                    }
                }
            }

        cancellableTopic = topicService.$topic
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedTopic in
                self?.topic = returnedTopic
            })
    }
}
