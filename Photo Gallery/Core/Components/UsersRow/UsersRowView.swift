//
//  UsersRowView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import SwiftUI

struct UsersRowView: View {
    
    let user: User
    
    var body: some View {
        HStack {
//            ProfileImageView(photo: <#T##Photo#>)
        }
    }
}

struct UsersRowView_Previews: PreviewProvider {
    static var previews: some View {
        UsersRowView(user: User(id: nil, updatedAt: nil, username: nil, name: nil, firstName: nil, lastName: nil, twitterUsername: nil, portfolioURL: nil, bio: nil, location: nil, links: nil, profileImage: nil, instagramUsername: nil, totalCollections: nil, totalLikes: nil, totalPhotos: nil, acceptedTos: nil, forHire: nil, social: nil))
    }
}
