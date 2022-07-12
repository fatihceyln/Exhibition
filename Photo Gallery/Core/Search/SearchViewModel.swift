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
    @Published var users: [User] = []
    @Published var randomPhotos: [Photo] = []
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    let searchPhotoService: SearchPhotoService = SearchPhotoService()
    let searchUserService: SearchUserService = SearchUserService()
    let randomPhotoService: RandomPhotoService = RandomPhotoService()

    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .sink { [weak self] returnedSearchText in
                self?.photos.removeAll()
                self?.users.removeAll()
                
                let text = returnedSearchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
                
                self?.searchPhotoService.searchText = text
                self?.searchUserService.searchText = text
                print(text)
                self?.searchPhotoService.downloadSearchResult()
                self?.searchUserService.downloadSearchResult()
            }
            .store(in: &cancellables)
        
        searchPhotoService.$photos
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
        
        searchUserService.$users
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedUsers in
                for item in returnedUsers {
                    if self?.users.allSatisfy({$0.id != item.id}) == true {
                        self?.users.append(item)
                    }
                }
            }
            .store(in: &cancellables)
        
        randomPhotoService.$photo
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPhoto in
                if let returnedPhoto = returnedPhoto {
                    if self?.randomPhotos.allSatisfy({$0.id != returnedPhoto.id}) == true {
                        self?.randomPhotos.append(returnedPhoto)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
