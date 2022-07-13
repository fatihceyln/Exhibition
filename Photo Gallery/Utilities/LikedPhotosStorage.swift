//
//  LikedPhotosStorage.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 13.07.2022.
//

import Foundation

class LikedPhotosStorage: ObservableObject {
    @Published var likedPhotoIds: [String] = []
    private let key: String = "likedPhotos"
    
    init() {
        getLikedPhotos()
    }
    
    private func getLikedPhotos() {
        guard let data = UserDefaults.standard.data(forKey: key) else {return}
        guard let returnedArray = try? JSONDecoder().decode([String].self, from: data) else {return}
        self.likedPhotoIds = returnedArray
    }
    
    func updateLikedPhoto(id: String) {
        if likedPhotoIds.contains(where: {$0 == id}) {
            likedPhotoIds.removeAll(where: {$0 == id})
        } else {
            likedPhotoIds.append(id)
        }
        print("updated \(id)")
        saveLikedPhotos()
    }
    
    private func saveLikedPhotos() {
        guard let data = try? JSONEncoder().encode(likedPhotoIds) else {return}
        UserDefaults.standard.set(data, forKey: key)
    }
}
