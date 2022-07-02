//
//  ProfileImageViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import Foundation
import Combine
import SwiftUI

class ProfileImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let photo: Photo
    private let service: ImageService
    
    init(photo: Photo) {
        self.photo = photo
        self.service = ImageService(photo: photo, options: .profile)
        self.isLoading = true
        addSubscribers()
    }
    
    private func addSubscribers() {
        service.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
