//
//  PhotoService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation
import Combine

class RandomPhotoService {
    @Published var photos: [Photo] = []
    private var cancellable: AnyCancellable? = nil
    private var page: Int = 1
    
    init() {
        downloadPhotos()
    }
    
    func downloadPhotos() {
        guard let url = URL(string: ApiURLs.editorial(byPage: page)) else {return}
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succesfull")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] returnedPhotoArray in
                
                for item in returnedPhotoArray {
                    if self?.photos.contains(where: {$0.id == item.id}) == false {
                        self?.photos.append(item)
                    }
                }
                
                self?.cancellable?.cancel()
            }

    }
}
