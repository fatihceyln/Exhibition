//
//  PhotoAttributesView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct PhotoAttributesView: View {
    let photo: Photo
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
            HStack {
                // MARK: Go user profile
                NavigationLink {
                    if let user = photo.user {
                        UserProfileView(user: user, photo: photo)
                    }
                } label: {
                    HStack {
                        if let user = photo.user {
                            UserProfileImageView(user: user)
                                .frame(width: 40, height: 40)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(photo.user?.name ?? "")
                            
                            if photo.sponsorship != nil {
                                Text("Sponsored by " + (photo.sponsorship?.sponsor?.name ?? ""))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .foregroundColor(.white)
                }

                
                Spacer()
                
                Label {
                    Text("\(photo.likes ?? 0)")
                } icon: {
                    Image(systemName: "heart.fill")
                }
            }
            .padding()
        }
    }
}
