//
//  UserProfileImageView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import SwiftUI

struct UserProfileImageView: View {
    @StateObject private var userProfileImageViewModel: UserProfileImageViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        _userProfileImageViewModel = StateObject(wrappedValue: UserProfileImageViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            if let image = userProfileImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
            } else if userProfileImageViewModel.isLoading {
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

struct UserProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileImageView(user: User(id: nil, updatedAt: nil, username: nil, name: nil, firstName: nil, lastName: nil, twitterUsername: nil, portfolioURL: nil, bio: nil, location: nil, links: nil, profileImage: nil, instagramUsername: nil, totalCollections: nil, totalLikes: nil, totalPhotos: nil, acceptedTos: nil, forHire: nil, social: nil))
    }
}
