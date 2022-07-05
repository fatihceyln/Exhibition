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
    let photoService: PhotoService
    private var cancellable: AnyCancellable? = nil
    
    init(topicEnum: TopicEnum) {
        self.photoService = PhotoService(topicEnum: topicEnum)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellable = photoService.$photos
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPhotos in
                for item in returnedPhotos {
                    if self?.photos.allSatisfy({$0.id != item.id}) == true {
                        self?.photos.append(item)
                    }
                }
            }

    }
}
