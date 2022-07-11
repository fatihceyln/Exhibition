//
//  SearchViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var photos: [Photo] = []
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    let searchService: SearchService = SearchService()
    
    private let turkishChars: [Character] = ["ı", "ğ", "ç", "ş", "ö", "ü"]
    private let englishChars: [Character] = ["i", "g", "c", "s", "o", "u"]
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] returnedSearchText in
                self?.photos.removeAll()
                
                let text = returnedSearchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
                
                self?.searchService.searchText = text
                print(text)
                self?.searchService.downloadSearchResult()
            }
            .store(in: &cancellables)
        
        searchService.$photos
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedPhotos in
                for item in returnedPhotos {
                    if self?.photos.allSatisfy({$0.id != item.id}) == true {
                        self?.photos.append(item)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
