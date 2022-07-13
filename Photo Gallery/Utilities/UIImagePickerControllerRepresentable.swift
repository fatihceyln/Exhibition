//
//  UIImagePickerController.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 13.07.2022.
//

import Foundation
import SwiftUI

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var imageData: Data?
    @Binding var showImagePicker: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imageData: $imageData, showImagePicker: $showImagePicker)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var imageData: Data?
        @Binding var showImagePicker: Bool
        
        init(imageData: Binding<Data?>, showImagePicker: Binding<Bool>) {
            self._imageData = imageData
            self._showImagePicker = showImagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let returnedImage = info[.editedImage] as? UIImage else {return}
            self.imageData = returnedImage.jpegData(compressionQuality: 1)
            self.showImagePicker.toggle()
        }
    }
}
