//
//  ProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var showAccountSettings: Bool = false
    
    @State private var userProfileContent: UserProfileContent = .photos
    
    @EnvironmentObject private var profileStore: ProfileStore
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.6)
                        .blur(radius: 2)
                }
                .clipped()
                .overlay(alignment: .bottomTrailing) {
                    Image("pp")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding()
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(viewModel.profileModel.firstname + " " + viewModel.profileModel.lastname)
                            .font(.title)
                            .bold()
                            .lineLimit(1)
                        
                        Text(viewModel.profileModel.username)
                            .foregroundColor(.gray)
                        
                        if !viewModel.profileModel.location.isEmpty {
                            Label(viewModel.profileModel.location, systemImage: "globe")
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
            
            Picker("User content", selection: $userProfileContent.animation(.easeInOut)) {
                Text("Photos")
                    .tag(UserProfileContent.photos)
                
                Text("Likes")
                    .tag(UserProfileContent.likes)
                
                Text("Collections")
                    .tag(UserProfileContent.collections)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    
                }
            }
        }
        .task({
            await viewModel.getProfileModel()
        })
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showAccountSettings) {
            NavigationView {
                AccountSettingsView(showAccountSettings: $showAccountSettings)
            }
            .environmentObject(viewModel)
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
            .preferredColorScheme(.dark)
    }
}
