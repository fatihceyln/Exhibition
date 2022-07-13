//
//  ProfileModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import Foundation
import SwiftUI

struct ProfileModel: Codable {
    var profileImageData: Data?
    var backgroundImageData: Data?
    var firstname: String = ""
    var lastname: String = ""
    var username: String = ""
    var email: String = ""
    var location: String = ""
    var website: String = ""
}

extension ProfileModel {
    struct ProfileData {
        var profileImageData: Data?
        var backgroundImageData: Data?
        var firstname: String = ""
        var lastname: String = ""
        var username: String = ""
        var email: String = ""
        var location: String = ""
        var website: String = ""
    }
    
    var profileData: ProfileData {
        ProfileData(profileImageData: profileImageData, backgroundImageData: backgroundImageData, firstname: firstname, lastname: lastname, username: username, email: email, location: location, website: website)
    }
    
    mutating func update(from data: ProfileData) {
        self.profileImageData = data.profileImageData
        self.backgroundImageData = data.backgroundImageData
        self.firstname = data.firstname
        self.lastname = data.lastname
        self.username = data.username
        self.email = data.email
        self.location = data.location
        self.website = data.website
    }
}

extension ProfileModel {
    func getProfileImage() -> UIImage? {
        return UIImage(data: profileImageData ?? Data())
    }
    
    func getBackgroundImage() -> UIImage? {
        return UIImage(data: backgroundImageData ?? Data())
    }
}
