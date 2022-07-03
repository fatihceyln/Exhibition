//
//  ListOfTopics.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 3.07.2022.
//

import Foundation

enum TopicEnum: String, Identifiable, CaseIterable {
    var id: Self { self }
    case editorial = "Editorial"
    case currentEvents = "Current Events"
    case wallpapers = "Wallpapers"
    case _3dRenders = "3D Renders"
    case texturesPatterns = "Textures & Patterns"
    case experimental = "Experimental"
    case architecture = "Architecture"
    case nature = "Nature"
    case businessWork = "Business & Work"
    case fashion = "Fashion"
    case film = "Film"
    case foodDrink = "Food & Drink"
    case healthWelness = "Health & Welness"
    case people = "People"
    case interiors = "Interiors"
    case streetPhotography = "Street Photography"
    case travel = "Travel"
    case animals = "Animals"
    case spirituality = "Spirituality"
    case artsCulture = "Arts & Culture"
    case history = "History"
    case athletics = "Athletics"
}

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


