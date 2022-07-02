//
//  ProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showAccountSettings: Bool = false
    
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
                .overlay(alignment: .bottomTrailing) {
                    Image("pp")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding()
                }
                .overlay(alignment: .bottomLeading) {
                    Text("Fatih Kilit")
                        .font(.title)
                        .bold()
                        .padding()
                }
                .overlay(alignment: .topLeading) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .padding()
                }
                .font(.title2)
                .overlay(alignment: .topTrailing) {
                    HStack(spacing: 15) {
                        Menu {
                            Button("Account Settings") {
                                showAccountSettings.toggle()
                            }
                            Button("Log Out") {}
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Color.white)
                        }
                        
                        Button {
                            share()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color.white)
                        }

                    }
                    .padding()
                    .font(.title2)
                }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(0..<25, id: \.self) { _ in
                        Image("bg")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
        .sheet(isPresented: $showAccountSettings) {
            AccountSettingsView()
        }
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
