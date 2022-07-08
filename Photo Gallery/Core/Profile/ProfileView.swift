//
//  ProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
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
                        .opacity(0.6)
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
                        .padding(.top, 30)
                }
                .font(.title2)
                .overlay(alignment: .topTrailing) {
                    HStack(alignment: .bottom, spacing: 15) {
                        Menu {
                            Button("Account Settings") {
                                showAccountSettings = true
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
                    .padding(.top, 30)
                    .font(.title2)
                }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showAccountSettings) {
            AccountSettingsView(showAccountSettings: $showAccountSettings)
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
