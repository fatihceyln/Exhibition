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
    let photoService: PhotoService
    private let userName: String
    private var cancellable: AnyCancellable? = nil
    @Published var showNoContent: Bool = false
    
    init(userName: String) {
        self.userName = userName
        photoService = PhotoService(userName: userName)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellable = photoService.$photos
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
