//
//  EditProfileView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject private var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var attributedString: AttributedString {
        var text = AttributedString("Edit your full information on unsplash.com")
        text.foregroundColor = .gray
        
        if let unsplash = text.range(of: "unsplash.com") {
            text[unsplash].foregroundColor = .white
        }
        
        return text
    }
    
    var body: some View {
        Form {
            Section {
                TextField("First name", text: $viewModel.profileModel.firstname)
                TextField("Last name", text: $viewModel.profileModel.lastname)
                TextField("Username", text: $viewModel.profileModel.username)
                TextField("Email", text: $viewModel.profileModel.email)
            } header: {
                Text("Profile")
            }
            
            Section {
                TextField("Location", text: $viewModel.profileModel.location)
                TextField("Website", text: $viewModel.profileModel.website)
            } header: {
                Text("About")
            }
            
            Section {} header: {
                Text(attributedString)
                    .headerProminence(.increased)
                    .font(.body)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.saveProfileModel()
                    }
                } label: {
                    Text("Save")
                }
                .foregroundColor(.white)
            }
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // Dismiss all sheets and go back to ProfileView
                    /*
                    let allScenes = UIApplication.shared.connectedScenes
                    let scene = allScenes.first(where: {$0.activationState == .foregroundActive})
                    
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.windows.first?.rootViewController?.dismiss(animated: true)
                    }
                    */
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.white)
            }
        })
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(ProfileViewModel())
            .preferredColorScheme(.dark)
    }
}
