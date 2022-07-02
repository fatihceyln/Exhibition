//
//  AccountSettingsView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

struct AccountSettingsView: View {
    var body: some View {
        VStack {
            Section {
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
                
            } header: {
                Text("Settings")
                    .headerProminence(.increased)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
            }
            
            Form {
                Section {
                    Text("Edit Profile")
                    Text("Change Password")
                    Text("Account")
                }
            }
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
