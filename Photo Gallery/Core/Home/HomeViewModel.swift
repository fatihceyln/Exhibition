//
//  HomeViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    let photoService: PhotoService = PhotoService()
    private var cancellable: AnyCancellable? = nil
    
    init() {
        getPhotos()
    }
    
    private func getPhotos() {
        cancellable = photoService.$photos
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Succesfull")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] returnedPhotos in
                for item in returnedPhotos {
                    if self?.photos.allSatisfy({$0.id != item.id}) == true {
                        self?.photos.append(item)
                    }
                }
            })
    }
}
