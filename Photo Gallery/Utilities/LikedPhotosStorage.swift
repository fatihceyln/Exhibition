//
//  LikedPhotosStorage.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 13.07.2022.
//

import Foundation

class LikedPhotosStorage: ObservableObject {
    @Published var likedPhotos: [Photo] = []
    private let key: String = "likedPhotos"
    
    init() {
        getLikedPhotos()
    }
    
    private func getLikedPhotos() {
        guard let data = UserDefaults.standard.data(forKey: key) else {return}
        guard let returnedArray = try? JSONDecoder().decode([Photo].self, from: data) else {return}
        self.likedPhotos = returnedArray
    }
    
    func updateLikedPhoto(photo: Photo) {
        if likedPhotos.contains(where: {$0.id == photo.id}) {
            likedPhotos.removeAll(where: {$0.id == photo.id})
        } else {
            likedPhotos.append(photo)
        }
        print("updated \(photo.id ?? "")")
        saveLikedPhotos()
    }
    
    private func saveLikedPhotos() {
        guard let data = try? JSONEncoder().encode(likedPhotos) else {return}
        UserDefaults.standard.set(data, forKey: key)
    }
}
