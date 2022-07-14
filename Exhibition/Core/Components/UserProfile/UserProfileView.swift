//
//  UserProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    let photo: Photo?
    @Environment(\.dismiss) private var dismiss
    @StateObject private var userProfileViewModel: UserProfileViewModel
    @State private var userProfileContent: UserProfileContent = .photos
    
    init(user: User, photo: Photo? = nil) {
        self.user = user
        self.photo = photo
        _userProfileViewModel = StateObject(wrappedValue: UserProfileViewModel(username: user.username ?? ""))
    }

    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    if let photo = photo {
                        PhotoImageView(photo: photo) {}
                            .scaledToFill()
                            .opacity(0.6)
                            .blur(radius: 20)
                    } else {
                        LinearGradient(colors: [.white.opacity(0.1), .white.opacity(0.4)], startPoint: .bottom, endPoint: .top)
                    }
                }
                .clipped()
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding()
                    .padding(.top, 30)
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        share()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    }
                    .padding()
                    .padding(.top, 30)
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack {
                        if let user = user {
                            UserProfileImageView(user: user)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .background {
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                            }
                        }
                        
                        if user.forHire == true {
                            HStack(spacing: 3) {
                                Image(systemName: "checkmark.seal")
                                
                                Text("Available for hire")
                            }
                            .font(.caption2.bold())
                            .foregroundColor(Color("AccentColor"))
                        }
                    }
                    .padding()
                    
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(user.name ?? "")
                            .font(.title)
                        
                        if let location = user.location {
                            Label(location, systemImage: "mappin.and.ellipse")
                                .opacity(0.7)
                        }
                        
                        if let bio = user.bio {
                            Label(bio, systemImage: "globe")
                                .customProfileLableStlye( titleFont: .caption)
                                .lineLimit(3)
                                .opacity(0.7)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.65, alignment: .leading)
                    .foregroundColor(.white)
                    .padding()
                }
            
            Picker("asdasd", selection: $userProfileContent) {
                Text("Photos")
                    .tag(UserProfileContent.photos)
                
                Text("Likes")
                    .tag(UserProfileContent.likes)
                
                Text("Collections")
                    .tag(UserProfileContent.collections)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            contentsOfUser
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .onChange(of: userProfileContent) { value in
            userProfileViewModel.photos.removeAll()
            userProfileViewModel.userPhotoService.page = 1
            userProfileViewModel.showNoContent = false
            userProfileViewModel.userPhotoService.userProfileContent = value
            userProfileViewModel.userPhotoService.downloadPhotos()
        }
    }
    
    private var contentsOfUser: some View {
        ScrollView(showsIndicators: false) {
            if userProfileViewModel.showNoContent == true {
                Text("No \(userProfileContent.rawValue)")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            } else {
                LazyVStack {
                    ForEach(userProfileViewModel.photos) { photo in
                        ZStack {
                            PhotoImageView(photo: photo) {
                                ZStack(alignment: .bottomLeading) {
                                    LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)

                                    if userProfileContent != .photos {
                                        PhotoAttributesView(photo: photo)
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                        .onAppear {
                            if userProfileViewModel.photos.isEmpty != true && userProfileViewModel.photos[userProfileViewModel.photos.count - 1].id == photo.id {
                                userProfileViewModel.userPhotoService.downloadPhotos()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func share() {
        guard let url = URL(string: user.portfolioURL ?? "https://unsplash.com") else {return}
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { scene in
            return scene.activationState == .foregroundActive
        }
        
        if let windowScene = scene as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: User(id: nil, updatedAt: nil, username: nil, name: nil, firstName: nil, lastName: nil, twitterUsername: nil, portfolioURL: nil, bio: nil, location: nil, links: nil, profileImage: nil, instagramUsername: nil, totalCollections: nil, totalLikes: nil, totalPhotos: nil, acceptedTos: nil, forHire: nil, social: nil))
    }
}
