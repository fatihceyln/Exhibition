//
//  PhotoImageView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import SwiftUI
import Photos

struct PhotoImageView<Content: View>: View {
    let photo: Photo
    @StateObject private var photoImageViewModel: PhotoImageViewModel
    private let overlayContent: Content
    
    private let imageSaver: ImageSaver = ImageSaver()
    @State private var isComplete: Bool = false
    @State private var scale: CGFloat = 1
    @State private var cornerRadius: CGFloat = 0
    
    @EnvironmentObject private var likedPhotosStorage: LikedPhotosStorage
    @Namespace private var namespace
    @State private var showInBottomTrailing: Bool = true
    @State private var saveAnimation: Bool = false
    
    init(photo: Photo, @ViewBuilder overlayContent: () -> Content) {
        self.photo = photo
        self.overlayContent = overlayContent()
        _photoImageViewModel = StateObject(wrappedValue: PhotoImageViewModel(photo: photo))
    }
    
    var body: some View {
        ZStack {
            if let image = photoImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .overlay {
                        if let id = photo.id, likedPhotosStorage.likedPhotoIds.contains(where: {$0 == id}) && !showInBottomTrailing {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(Color("heartColor"))
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .font(.title3)
                                .padding()
                                .transition(.scale)
                                .matchedGeometryEffect(id: "heart", in: namespace)
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if let id = photo.id, likedPhotosStorage.likedPhotoIds.contains(where: {$0 == id}) && showInBottomTrailing {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(Color("heartColor"))
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .font(.title3)
                                .padding()
                                .transition(.move(edge: .bottom))
                                .matchedGeometryEffect(id: "heart", in: namespace)
                        }
                    }
                    .overlay(content: {
                        if saveAnimation && PHPhotoLibrary.authorizationStatus(for: .addOnly) == .authorized {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                                .transition(.scale)
                        } else if saveAnimation && PHPhotoLibrary.authorizationStatus(for: .addOnly) != .authorized {
                            VStack {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.red)
                                    .transition(.scale)
                            }
                        }
                    })
                    .overlay {
                        overlayContent
                    }
                    .cornerRadius(cornerRadius)
                    .scaleEffect(scale)
                    .scaleEffect(isComplete ? 0.9 : 1)
                    .blur(radius: isComplete ? 5 : 0)
                    .onTapGesture(count: 2) {
                        if let id = photo.id {
                            withAnimation {
                                likedPhotosStorage.updateLikedPhoto(id: id)
                                if likedPhotosStorage.likedPhotoIds.contains(where: {$0 == id}) {
                                    showInBottomTrailing = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation {
                                            showInBottomTrailing = true
                                        }
                                    }
                                } else {
                                    withAnimation {
                                        showInBottomTrailing = false
                                    }
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isComplete = false
                            cornerRadius = 0
                        }
                        print("aa")
                    }
                    .onLongPressGesture(minimumDuration: 0.6) {
                        withAnimation {
                            isComplete = true
                            cornerRadius = 20
                        }
                    } onPressingChanged: { isPressing in
                        
                        if isPressing && !isComplete {
                            withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                scale = 0.95
                                cornerRadius = 20
                            }
                        } else if !isPressing && !isComplete {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                scale = 1
                                cornerRadius = 0
                            }
                        }
                    }
                    .padding(isComplete ? 10 : 0)
                    .overlay(alignment: .topTrailing) {
                        if isComplete {
                            Button {
                                imageSaver.writeToPhotoAlbum(image: image)
                                withAnimation {
                                    isComplete = false
                                    cornerRadius = 0
                                    
                                    saveAnimation = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            saveAnimation = false
                                        }
                                    }
                                }
                            } label: {
                                Text("Save")
                            }
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThickMaterial)
                            }
                            .transition(.opacity)
                            .padding([.top, .trailing])
                        }
                    }
                    .onDisappear {
                        isComplete = false
                    }
                
                
            } else if photoImageViewModel.isLoading {
                if let image = UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 32, height: 32), punch: 0.5) {
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
        PhotoImageView(photo: photo, overlayContent: {
            
        })
        .preferredColorScheme(.dark)
    }
}

