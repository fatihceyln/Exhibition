//
//  CategoryPhotosView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import SwiftUI

struct CategoryPhotosView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var searchViewModel: SearchViewModel
    let category: BrowseByCategory
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(searchViewModel.photos) { photo in
                        ZStack(alignment: .bottomLeading) {
                            PhotoImageView(photo: photo) {
//                                ZStack(alignment: .bottomLeading) {
//                                    LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
//
//                                    NavigationLink {
//                                        if let user = photo.user {
//                                            UserProfileView(user: user)
//                                        }
//                                    } label: {
//                                        Text(photo.user?.name ?? "")
//                                            .foregroundColor(.white)
//                                            .font(.headline)
//                                            .padding(.horizontal)
//                                            .padding(.vertical, 5)
//                                    }
//                                }
                                
                                PhotoAttributesView(photo: photo)
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(category.rawValue)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            searchViewModel.searchText = category.rawValue
        })
        .onDisappear(perform: {
            searchViewModel.searchText = ""
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    searchViewModel.photos.removeAll()
                    searchViewModel.searchText = ""
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.white)
            }
        })
    }
}

struct CategoryPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryPhotosView(searchViewModel: SearchViewModel(), category: BrowseByCategory.animals)
                .preferredColorScheme(.dark)
        }
    }
}
