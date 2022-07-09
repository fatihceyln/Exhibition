//
//  TopicView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import SwiftUI

struct TopicView: View {
    
    @StateObject private var topicViewModel: TopicViewModel
    
    init(topicEnum: TopicEnum) {
        self._topicViewModel = StateObject(wrappedValue: TopicViewModel(topicEnum: topicEnum, id: topicEnum.topicId))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                if let topic = topicViewModel.topic {
                    ZStack(alignment: .topLeading) {
                        if let image = UIImage(blurHash: topic.coverPhoto?.blurHash ?? "", size: CGSize(width: 32, height: 32), punch: 0.8) {
                            Image(uiImage: image)
                                .resizable()
                                .overlay(content: {
                                    Color.black.opacity(0.5)
                                })
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(topic.title ?? "")
                                .font(.title2)
                                .bold()
                            
                            Text(topic.description?.trimmingCharacters(in: .newlines) ?? "")
                                .font(.caption)
                                .lineLimit(3)
                            
                            Button {
                                
                            } label: {
                                Text("Submit a photo")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background {
                                        Color.white
                                    }
                                    .cornerRadius(5)
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 30)
                        }
                        .foregroundColor(.white)
                        .padding(.top, 100)
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                } else {
                    EmptyView()
                }
                
                ForEach(topicViewModel.photos) { photo in
                    ZStack(alignment: .bottomLeading) {
                        PhotoImageView(photo: photo)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                    .onAppear {
                        if topicViewModel.photos.count > 5 {
                            if photo.id == topicViewModel.photos[topicViewModel.photos.count - 2].id {
                                topicViewModel.photoService.downloadPhotos()
                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView(topicEnum: .wallpapers)
    }
}
