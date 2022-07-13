//
//  ListOfTopics.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import Foundation

struct Topic: Codable, Identifiable {
    
    let id, slug, title, description: String?
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case description
        case coverPhoto = "cover_photo"
    }
}

struct CoverPhoto: Codable {
    
    let id: String?
    let width, height: Int?
    let blurHash: String?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id
        case width, height
        case blurHash = "blur_hash"
        case urls
    }
}


