//
//  HomeView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            mainScrollableView
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
    
    private var mainScrollableView: some View {
        ScrollView {
            LazyVStack {
                ForEach(homeViewModel.photos) { photo in
                    ZStack(alignment: .bottomLeading) {
                        PhotoImageView(photo: photo, homeViewModel: homeViewModel)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                    .onAppear {
                        if homeViewModel.photos.count > 5 {
                            if photo.id == homeViewModel.photos[homeViewModel.photos.count - 2].id {
                                homeViewModel.service.downloadPhotos()
                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
