//
//  UserProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import SwiftUI

enum UserProfileContent: String {
    case photos, likes, collections
}

struct UserProfileView: View {
    let photo: Photo
    @Environment(\.dismiss) private var dismiss
    @StateObject private var userProfileViewModel: UserProfileViewModel
    @State private var userProfileContent: UserProfileContent = .photos
    
    init(photo: Photo) {
        self.photo = photo
        _userProfileViewModel = StateObject(wrappedValue: UserProfileViewModel(userName: photo.user?.username ?? ""))
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    
                    PhotoImageView(photo: photo, showAttributes: false)
                        .scaledToFill()
                        .opacity(0.6)
                        .blur(radius: 20)
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
                        ProfileImageView(photo: photo)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .background {
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                            }
                        
                        if photo.user?.forHire == true {
                            HStack(spacing: 3) {
                                Image(systemName: "checkmark.seal")
                                
                                Text("Available for hire")
                            }
                            .font(.caption.bold())
                            .foregroundColor(Color("AccentColor"))
                        }
                    }
                    .padding()
                    
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(photo.user?.name ?? "")
                            .font(.title)
                        
                        if let location = photo.user?.location {
                            Label(location, systemImage: "mappin.and.ellipse")
                        }
                        
                        if let bio = photo.user?.bio {
                            Label(bio, systemImage: "globe")
                                .customProfileLableStlye( titleFont: .caption)
                                .lineLimit(3)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                    .foregroundColor(.white)
                    .padding()
                }
            
            Picker("asdasd", selection: $userProfileContent.animation(.easeInOut)) {
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
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onChange(of: userProfileContent) { value in
            userProfileViewModel.photos.removeAll()
            userProfileViewModel.photoService.page = 1
            userProfileViewModel.showNoContent = false
            userProfileViewModel.photoService.userProfileContent = value
            userProfileViewModel.photoService.downloadPhotos()
        }
    }
    
    private var contentsOfUser: some View {
        ScrollView(showsIndicators: false) {
            if userProfileViewModel.showNoContent == true {
                Text("No \(userProfileContent.rawValue)")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .animation(.none, value: userProfileContent)
            } else {
                LazyVStack {
                    ForEach(userProfileViewModel.photos) { photo in
                        ZStack {
                            PhotoImageView(photo: photo, showAttributes: false)
                                .overlay {
                                    ZStack(alignment: .bottomLeading) {
                                        LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
                                        
                                        if userProfileContent != .photos {
                                            Text(photo.user?.name ?? "")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .padding(.horizontal)
                                                .padding(.vertical, 5)
                                        }
                                    }
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                        .onAppear {
                            if userProfileViewModel.photos[userProfileViewModel.photos.count - 2].id == photo.id {
                                userProfileViewModel.photoService.downloadPhotos()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func share() {
        guard let url = URL(string: photo.user?.portfolioURL ?? "https://unsplash.com") else {return}
        
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

struct CustomProfileLabelStyle: LabelStyle {
    let titleFont: Font
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            configuration.icon
            
            configuration.title
                .font(titleFont)
        }
    }
}

extension View {
    func customProfileLableStlye(titleFont: Font) -> some View {
        self
            .labelStyle(CustomProfileLabelStyle(titleFont: titleFont))
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(photo: photo)
    }
}
