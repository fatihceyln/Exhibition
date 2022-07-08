//
//  HomeView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    @State private var selectedTopic: TopicEnum = .editorial
    
    var body: some View {
        TabView {
            NavigationView {
                ZStack(alignment: .top) {
                    ScrollView(.init()) { // It's must if you want to use ignoreSafeArea
                        TabView(selection: $selectedTopic) {
                            mainScrollableView
                            ForEach(TopicEnum.allCases.dropFirst()) { topicEnum in
                                TopicView(topicEnum: topicEnum)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                    .ignoresSafeArea()
                    
                    selectableTopics
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .frame(height: 2)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                        .background {
                            Rectangle()
                                .fill(Color.black.opacity(0.5))
                                .edgesIgnoringSafeArea(.top)
                        }
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
    
    private var selectableTopics: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack {
                    ForEach(TopicEnum.allCases) { topic in
                        Text(topic.rawValue)
                            .font(.title3.bold())
                            .tag(topic)
                            .padding(.horizontal, 5)
                            .padding(.bottom, 5)
                            .background {
                                if selectedTopic == topic {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white)
                                        .frame(height: 3)
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .padding(.horizontal, 3)
                                }
                            }
                            .onTapGesture {
                                selectedTopic = topic
                            }
                    }
                }
                .padding(.horizontal)
                .onChange(of: selectedTopic) { value in
                    withAnimation(.easeInOut) {
                        proxy.scrollTo(value, anchor: .bottom)
                    }
                }
            }
        }
    }
    
    private var mainScrollableView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(homeViewModel.photos) { photo in
                    ZStack(alignment: .bottomLeading) {
                        PhotoImageView(photo: photo)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                    .onAppear {
                        if homeViewModel.photos.count > 5 {
                            if photo.id == homeViewModel.photos[homeViewModel.photos.count - 2].id {
                                homeViewModel.photoService.downloadPhotos()
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
            .preferredColorScheme(.dark)
    }
}
