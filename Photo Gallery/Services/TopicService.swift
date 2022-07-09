//
//  TopicService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 9.07.2022.
//

import Foundation
import Combine

class TopicService {
    @Published var topic: Topic? = nil
    private var cancellable: AnyCancellable? = nil
    private let id: String
    
    init(id: String) {
        self.id = id
        downloadTopic()
    }
    
    private func downloadTopic() {
        guard let url = URL(string: ApiURLs.topic(id: id)) else {return}
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: Topic.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedTopic in
                self?.topic = returnedTopic
            })
    }
}
