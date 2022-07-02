//
//  PhotoImageView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import SwiftUI

struct PhotoImageView: View {
    let photo: Photo
    @StateObject private var photoImageViewModel: PhotoImageViewModel
    
    init(photo: Photo, homeViewModel: HomeViewModel) {
        self.photo = photo
        _photoImageViewModel = StateObject(wrappedValue: PhotoImageViewModel(photo: photo))
    }
    
    var body: some View {
        ZStack {
            if let image = photoImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .overlay {
                        PhotoAttributesView(photo: photo)
                    }
            } else if photoImageViewModel.isLoading {
                if let image = UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 32, height: 32)) {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.ultraThinMaterial)
                        }
                }
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)        
            }
        }
    }
}

struct PhotoImageView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoImageView(photo: photo, homeViewModel: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
