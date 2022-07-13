//
//  Photo_GalleryApp.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import SwiftUI

@main
struct Photo_GalleryApp: App {
    
    @StateObject private var profileViewModel: ProfileViewModel = ProfileViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color.black.opacity(0.5))
        
        // Use this appearance when scrolling behind the TabView:
        UITabBar.appearance().standardAppearance = appearance
        // Use this appearance when scrolled all the way up:
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    
    
    var body: some Scene {
        
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
                .environmentObject(profileViewModel)
                .task {
                    await profileViewModel.getProfileModel()
                }
        }
    }
}
