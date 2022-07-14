//
//  ProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    @EnvironmentObject private var likedPhotosStorage: LikedPhotosStorage
    
    @State private var showAccountSettings: Bool = false
    @State private var userProfileContent: UserProfileContent = .photos
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    if let backgroundImage = profileViewModel.profileModel.getBackgroundImage() {
                        Image(uiImage: backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .opacity(0.6)
                            .blur(radius: 2)
                    } else {
                        LinearGradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)], startPoint: .bottom, endPoint: .top)
                    }
                }
                .clipped()
                .overlay(alignment: .bottomTrailing) {
                    if let profileImage = profileViewModel.profileModel.getProfileImage() {
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding()
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(Circle())
                            .padding()
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(profileViewModel.profileModel.firstname + " " + profileViewModel.profileModel.lastname)
                            .font(.title)
                            .bold()
                            .lineLimit(1)
                        
                        Text(profileViewModel.profileModel.username)
                            .foregroundColor(.gray)
                        
                        if !profileViewModel.profileModel.location.isEmpty {
                            Label(profileViewModel.profileModel.location, systemImage: "globe")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .overlay(alignment: .topLeading) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .padding()
                        .padding(.top, 30)
                }
                .font(.title2)
                .overlay(alignment: .topTrailing) {
                    HStack(alignment: .bottom, spacing: 15) {
                        Menu {
                            Button("Account Settings") {
                                showAccountSettings = true
                            }
                            Button("Log Out") {}
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Color.white)
                        }
                        
                        Button {
                            share()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    .padding(.top, 30)
                    .font(.title2)
                }
            
            Picker("User content", selection: $userProfileContent) {
                Text("Photos")
                    .tag(UserProfileContent.photos)
                
                Text("Likes")
                    .tag(UserProfileContent.likes)
                
                Text("Collections")
                    .tag(UserProfileContent.collections)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch userProfileContent {
            case .photos:
                Spacer()
                
                Text("No photos")
                    
                Spacer()
            case .likes:
                if likedPhotosStorage.likedPhotos.isEmpty {
                    Spacer()
                    Text("No likes")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(likedPhotosStorage.likedPhotos) { photo in
                                ZStack {
                                    PhotoImageView(photo: photo) {
//                                        ZStack(alignment: .bottomLeading) {
//                                            LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
//
//                                            NavigationLink {
//                                                if let user = photo.user {
//                                                    UserProfileView(user: user)
//                                                }
//                                            } label: {
//                                                Text(photo.user?.name ?? "")
//                                                    .foregroundColor(.white)
//                                                    .font(.headline)
//                                                    .padding(.horizontal)
//                                                    .padding(.vertical, 5)
//                                            }
//                                        }
                                        
                                        PhotoAttributesView(photo: photo)
                                    }
                                }
                            }
                        }
                    }
                }
            case .collections:
                Spacer()
                
                Text("No Collections")
                    
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showAccountSettings) {
            NavigationView {
                AccountSettingsView(showAccountSettings: $showAccountSettings, profileModel: $profileViewModel.profileModel)
            }
        }
    }
    
    private func share() {
        guard let url = URL(string: "https://unsplash.com") else {return}
        
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
            .environmentObject(LikedPhotosStorage())
            .preferredColorScheme(.dark)
    }
}
