//
//  UserImageViewModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation
import SwiftUI
import Combine

class UserProfileImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private let user: User
    private let userProfileImageService: UserProfileImageService
    
    init(user: User) {
        self.user = user
        self.isLoading = true
        self.userProfileImageService = UserProfileImageService(user: user)
        addSubscribers()
    }
    
    private func addSubscribers() {
        userProfileImageService.$image
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] retunedImage in
                self?.image = retunedImage
            }
            .store(in: &cancellables)
    }
}
