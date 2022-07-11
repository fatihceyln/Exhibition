//
//  SearchUser.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation

struct SearchUser: Codable {
    let users: [User]?

    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}
