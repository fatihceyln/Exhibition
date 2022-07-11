//
//  RandomPhotoService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 9.07.2022.
//

import Foundation
import Combine

class RandomPhotoService {
    @Published var photo: Photo? = nil
    private var cancellable: AnyCancellable? = nil
    
    init() {
        downloadPhoto()
    }
    
    func downloadPhoto() {
        
        guard let url = URL(string: ApiURLs.randomPhoto) else {return}
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: Photo.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedPhoto in
                self?.photo = returnedPhoto
                self?.cancellable?.cancel()
            })
    }
}
