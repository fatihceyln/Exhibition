//
//  SearchPhoto.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import Foundation

struct SearchPhoto: Codable {
    let photos: [Photo]?

    enum CodingKeys: String, CodingKey {
        case photos = "results"
    }
}
