//
//  UserProfileViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    let userPhotoService: UserPhotoService
    private let username: String
    private var cancellable: AnyCancellable? = nil
    @Published var showNoContent: Bool = false
    
    init(username: String) {
        self.username = username
        userPhotoService = UserPhotoService(username: username)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellable = userPhotoService.$photos
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedPhotos in
                for item in returnedPhotos {
                    if self?.photos.allSatisfy({$0.id != item.id}) == true {
                        self?.photos.append(item)
                    }
                }
                
                if returnedPhotos.isEmpty && self?.photos.count == 0{
                    self?.showNoContent = true
                } else {
                    self?.showNoContent = false
                }
            })
    }
}
