//
//  UploadPhotoView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import SwiftUI

struct UploadPhotoView: View {
    var body: some View {
        VStack {
            Text("Contribute to Photo Gallery")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 5, lineJoin: .round, dash: [8]))
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width * 0.91, height: 190)
                .overlay {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.6))
                            .padding(.horizontal)
                            .overlay(alignment: .topTrailing) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .scaledToFit()
                                    .foregroundStyle(.white, .blue)
                                    .symbolRenderingMode(.palette)
                            }
                        
                        Text("Upload your photo to the largest library of open photography.")
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                    }
                }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UploadPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPhotoView()
            .preferredColorScheme(.dark)
    }
}
