//
//  AccountSettingsView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @Binding var showAccountSettings: Bool
    
    var body: some View {
        VStack {
            
            ZStack {
                Image("bg")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 2) // always give blur before corner radius
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.3))
                    }
                
                Button {
                    
                } label: {
                    VStack {
                        Image("pp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Text("Change Profile Photo")
                    }
                    .foregroundColor(.white)
                }
                
            }
            .padding()
            
            Form {
                Section {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        Text("Edit Profile")
                    }
                    Text("Change Password")
                    Text("Account")
                }
            }
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showAccountSettings = false
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundColor(.white)
            }
        })
        .preferredColorScheme(.dark)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Settings")
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountSettingsView(showAccountSettings: .constant(true))
        }
    }
}
