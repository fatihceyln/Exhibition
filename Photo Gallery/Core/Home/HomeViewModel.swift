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
    @Published var randomPhoto: Photo? = nil
    let photoService: PhotoService = PhotoService()
    let randomPhotoService: RandomPhotoService = RandomPhotoService()
    private var photosCancellable: AnyCancellable? = nil
    private var randomPhotoCancellable: AnyCancellable? = nil
    
    init() {
        getPhotos()
    }
    
    private func getPhotos() {
        photosCancellable = photoService.$photos
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
        
        randomPhotoCancellable = randomPhotoService.$photo
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedPhoto in
                self?.randomPhoto = returnedPhoto
            })
    }
}
