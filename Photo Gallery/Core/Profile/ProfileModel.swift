//
//  ProfileModel.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import Foundation

struct ProfileModel: Codable {
    var firstname: String
    var lastname: String
    var username: String
    var email: String
    var location: String
    var website: String
    
    init(firstname: String = "", lastname: String = "", username: String = "", email: String = "", location: String = "", website: String = "") {
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.email = email
        self.location = location
        self.website = website
    }
    
    func isAllEmpty() -> Bool {
        return firstname.isEmpty && lastname.isEmpty && username.isEmpty && email.isEmpty && location.isEmpty && website.isEmpty
    }
}
