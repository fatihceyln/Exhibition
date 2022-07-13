//
//  ImageSaver.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import SwiftUI
import Photos

class ImageSaver: NSObject {
    
    override init() {
        super.init()
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { _ in
            
        }
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletion), nil)
    }
    
    @objc private func saveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERRORRR: \(error)")
        } else {
            print("SUCCESFULLLLLLL")
        }
    }
}
