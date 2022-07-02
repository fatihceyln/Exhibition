//
//  ProfileImageView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct ProfileImageView: View {
    
    @StateObject private var profileImageViewModel: ProfileImageViewModel
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        self._profileImageViewModel = StateObject(wrappedValue: ProfileImageViewModel(photo: photo))
    }
    
    var body: some View {
        ZStack {
            if let image = profileImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
            } else if profileImageViewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.ultraThinMaterial)
                    }
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .clipShape(Circle())
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(photo: photo)
    }
}
