//
//  SearchView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import SwiftUI

enum SearchCategory: String {
    case photos, collections, users
}

struct SearchView: View {
    
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    @State private var searchCategory: SearchCategory = .photos
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            searchSection
            
            if searchViewModel.searchText.isEmpty {
                ScrollView {
                    browseByCategory
                    
                    discoverSection
                }
            } else {
                
                Picker("Search Category", selection: $searchCategory.animation(.easeInOut)) {
                    Text("Photos")
                        .tag(SearchCategory.photos)
                    
                    Text("Collections")
                        .tag(SearchCategory.collections)
                    
                    Text("Users")
                        .tag(SearchCategory.users)
                }
                .pickerStyle(.segmented)
                
                switch searchCategory {
                case .photos:
                    searchPhotosView
                case .collections:
                    searchCollectionsView
                case .users:
                    searchUsersView
                }
            }
            
        }
    }
    
    private var searchUsersView: some View {
        List {
            ForEach(searchViewModel.users) { user in
                ZStack(alignment: .bottomLeading) {
                    NavigationLink {
                        UserProfileView(user: user)
                    } label: {
                        UsersRowView(user: user)
                    }
                }
                .onAppear {
                    if searchViewModel.users.count > 5 {
                        if user.id == searchViewModel.users[searchViewModel.users.count - 2].id {
                            searchViewModel.searchUserService.downloadSearchResult()
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private var searchCollectionsView: some View {
        ScrollView {
            
        }
    }
    
    private var searchPhotosView: some View {
        ScrollView {
            LazyVStack {
                ForEach(searchViewModel.photos) { photo in
                    ZStack(alignment: .bottomLeading) {
                        PhotoImageView(photo: photo) {
                            ZStack(alignment: .bottomLeading) {
                                LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
                                
                                NavigationLink {
                                    if let user = photo.user {
                                        UserProfileView(user: user)
                                    }
                                } label: {
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
                        if searchViewModel.photos.count > 5 {
                            if photo.id == searchViewModel.photos[searchViewModel.photos.count - 2].id && !searchViewModel.photos.isEmpty {
                                searchViewModel.searchPhotoService.downloadSearchResult()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var discoverSection: some View {
        VStack {
            Text("Discover")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(searchViewModel.randomPhotos) { photo in
                        ZStack {
                            PhotoImageView(photo: photo) {
                                ZStack(alignment: .bottomLeading) {
                                    LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
                                    
                                    NavigationLink {
                                        if let user = photo.user {
                                            UserProfileView(user: user)
                                        }
                                    } label: {
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
                            if searchViewModel.randomPhotos.count > 0 && searchViewModel.randomPhotos.count < 5 {
                                searchViewModel.randomPhotoService.downloadPhoto()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var browseByCategory: some View {
        VStack(spacing: 0) {
            Text("Browse by Category")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(BrowseByCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            CategoryPhotosView(searchViewModel: searchViewModel, category: category)
                        } label: {
                            Image(category.rawValue)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 240, height: 150)
                                .cornerRadius(10)
                                .overlay {
                                    Color.black.opacity(0.4)
                                    
                                    Text(category.rawValue)
                                        .font(.title2.bold())
                                }
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .frame(height: 180)
        }
        .padding(.top)
    }
    
    private var searchSection: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Seach photos, collections, users", text: $searchText)
                .disableAutocorrection(true)
                .submitLabel(.done)
                .onSubmit {
                    searchViewModel.searchText = searchText
                }
            
            Spacer()
            
            Button {
                searchViewModel.searchText = ""
                searchText = ""
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.gray)
            }
            .opacity(searchViewModel.searchText.isEmpty ? 0.0 : 1.0)
            .animation(.easeInOut, value: searchViewModel.searchText)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
