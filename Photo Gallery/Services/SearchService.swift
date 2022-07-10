//
//  SearchService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import Foundation
import Combine

class SearchService {
    @Published var photos: [Photo] = []
    var searchText: String = ""
    private var page: Int = 1
    private var cancellable: AnyCancellable? = nil
    var searchCategory: SearchCategory = .photos
    
    func downloadSearchResult() {
        
        var url: URL?
        
        switch searchCategory {
        case .photos:
            url = URL(string: ApiURLs.searchPhotos(text: searchText, page: page))
        case .collections:
            url = URL(string: ApiURLs.searchPhotos(text: searchText, page: page))
        case .users:
            url = URL(string: ApiURLs.searchPhotos(text: searchText, page: page))
        }
        
        guard let url = url else {return}
        
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { [weak self] returnedSearchPhoto in
                if let returnedPhotos = returnedSearchPhoto.photos {
                    self?.photos = returnedPhotos
                }
                self?.cancellable?.cancel()
            })
    }
}
