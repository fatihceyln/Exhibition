//
//  AccountSettingsView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 2.07.2022.
//

import SwiftUI

enum imagePickerOption {
    case profile, background
}

struct AccountSettingsView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @Binding var showAccountSettings: Bool
    @Binding var profileModel: ProfileModel
    @State private var profileData: ProfileModel.ProfileData = ProfileModel.ProfileData()
    
    @State private var showImagePicker: Bool = false
    
    @State private var imagePickerOption: imagePickerOption = .profile
    
    var body: some View {
        VStack {
            
            ZStack {
                if let backgroundImage = profileViewModel.profileModel.getBackgroundImage() {
                    Image(uiImage: backgroundImage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
                        .scaledToFill()
                        .blur(radius: 2) // always give blur before corner radius
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.3))
                        }
                        .overlay(alignment: .topTrailing) {
                            Button {
                                imagePickerOption = .background
                                showImagePicker.toggle()
                            } label: {
                                Text("Change Background Photo")
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThinMaterial)
                                    }
                                    .foregroundColor(.white)
                            }
                            .padding(5)
                        }
                } else {
                    LinearGradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.3)], startPoint: .bottom, endPoint: .top)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
                        .scaledToFill()
                        .cornerRadius(10)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                imagePickerOption = .background
                                showImagePicker.toggle()
                            } label: {
                                Text("Change Background Photo")
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThinMaterial)
                                    }
                                    .foregroundColor(.white)
                            }
                            .padding(5)
                        }
                }
                
                Button {
                    imagePickerOption = .profile
                    showImagePicker.toggle()
                } label: {
                    VStack {
                        if let profileImage = profileViewModel.profileModel.getProfileImage() {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        
                        Text("Change Profile Photo")
                    }
                    .padding(.vertical)
                    .foregroundColor(.white)
                }
                
            }
            .padding()
            
            Form {
                Section {
                    NavigationLink {
                        EditProfileView(profileData: $profileData)
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        profileModel.update(from: profileData)
                                        Task {
                                            await profileViewModel.saveProfileModel()
                                        }
                                    } label: {
                                        Text("Save")
                                    }
                                    .foregroundColor(.white)
                                }
                            })
                    } label: {
                        Text("Edit Profile")
                    }
                    Text("Change Password")
                    Text("Account")
                }
            }
            Spacer()
        }
        .onAppear {
            self.profileData = profileModel.profileData
        }
        .onChange(of: profileViewModel.profileModel.profileImageData, perform: { _ in
            Task {
                await profileViewModel.saveProfileModel()
                self.profileData = profileModel.profileData 
            }
        })
        .onChange(of: profileViewModel.profileModel.backgroundImageData, perform: { _ in
            Task {
                await profileViewModel.saveProfileModel()
                self.profileData = profileModel.profileData
            }
        })
        .sheet(isPresented: $showImagePicker, content: {
            switch imagePickerOption {
            case .profile:
                UIImagePickerControllerRepresentable(imageData: $profileViewModel.profileModel.profileImageData, showImagePicker: $showImagePicker)
            case .background:
                UIImagePickerControllerRepresentable(imageData: $profileViewModel.profileModel.backgroundImageData, showImagePicker: $showImagePicker)
            }
        })
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
            AccountSettingsView(showAccountSettings: .constant(true), profileModel: .constant(ProfileModel()))
        }
    }
}
