//
//  TopicService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import Foundation
import Combine

class TopicService: ObservableObject {
    @Published var topics: [Topic] = []
    private var cancellable: AnyCancellable? = nil
    
    init() {
        downloadTopics()
    }
    
    func downloadTopics() {
        guard let url = URL(string: ApiURLs.topics) else {return}
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: [Topic].self, decoder: JSONDecoder())
            .sink { _ in
                
            } receiveValue: { [weak self] returnedListOfTopics in
                self?.topics = returnedListOfTopics
                self?.cancellable?.cancel()
            }

    }
}
