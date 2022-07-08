//
//  UserProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 5.07.2022.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                .background {
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 2)
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
                    Image("pp")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding()
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(user.name ?? "")
                            .font(.title)
                        
                        Label(user.location ?? "", systemImage: "map.fill")
                        Label(user.bio ?? "", systemImage: "globe")
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                            .lineLimit(1)
                    }
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
        guard let url = URL(string: "https://unsplash.com") else {return}
        
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

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: photo.user!)
    }
}
