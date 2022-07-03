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
        self._topicViewModel = StateObject(wrappedValue: TopicViewModel(topicEnum: topicEnum))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(topicViewModel.photos) { photo in
                    ZStack(alignment: .bottomLeading) {
                        PhotoImageView(photo: photo)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: photo.height?.calculateHeight(width: photo.width ?? 0, height: photo.height ?? 0))
                    .onAppear {
                        if topicViewModel.photos.count > 5 {
                            if photo.id == topicViewModel.photos[topicViewModel.photos.count - 2].id {
                                topicViewModel.topicPhotoService.downloadTopicPhoto()
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
