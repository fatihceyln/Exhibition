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
    let topicPhotoService: TopicPhotoService
    private var cancellable: AnyCancellable? = nil
    
    init(topicEnum: TopicEnum) {
        self.topicPhotoService = TopicPhotoService(topicEnum: topicEnum)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellable = topicPhotoService.$photos
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedTopicPhotos in
                self?.photos = returnedTopicPhotos
            }

    }
}
