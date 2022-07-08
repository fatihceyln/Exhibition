//
//  UserProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import SwiftUI

struct UserProfileView: View {
    let photo: Photo
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    
                    PhotoImageView(photo: photo, showAttributes: false)
                        .scaledToFill()
                        .opacity(0.6)
                        .blur(radius: 20)
                }
                .clipped()
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding()
                    .padding(.top, 30)
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        share()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    }
                    .padding()
                    .padding(.top, 30)
                }
                .overlay(alignment: .bottomTrailing) {
                    ProfileImageView(photo: photo)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .background {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        }
                        .padding()
                        
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(photo.user?.name ?? "")
                            .font(.title)
                        
                        if let location = photo.user?.location {
                            Label(location, systemImage: "mappin.and.ellipse")
                        }
                        
                        if let bio = photo.user?.bio {
                            Label(bio, systemImage: "globe")
                                .customProfileLableStlye( titleFont: .caption)
                                .lineLimit(3)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                    .foregroundColor(.white)
                    .padding()
                }
            
            ScrollView(showsIndicators: false) {
                
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    private func share() {
        guard let url = URL(string: photo.user?.portfolioURL ?? "https://unsplash.com") else {return}
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { scene in
            return scene.activationState == .foregroundActive
        }
        
        if let windowScene = scene as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true)
        }
    }
}

struct CustomProfileLabelStyle: LabelStyle {
    let titleFont: Font
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            configuration.icon
            
            configuration.title
                .font(titleFont)
        }
    }
}

extension View {
    func customProfileLableStlye(titleFont: Font) -> some View {
        self
            .labelStyle(CustomProfileLabelStyle(titleFont: titleFont))
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(photo: photo)
    }
}
