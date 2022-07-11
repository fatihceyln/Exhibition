//
//  Enums.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation

enum UserProfileContent: String {
    case photos, likes, collections
}

enum ImageOptions {
    case photo, profile
}

enum BrowseByCategory: String, CaseIterable {
    case nature = "Nature"
    case textures = "Textures"
    case black_and_white = "Black and White"
    case abstract = "Abstract"
    case space = "Space"
    case minimal = "Minimal"
    case animals = "Animals"
    case sky = "Sky"
    case flowers = "Flowers"
    case travel = "Travel"
    case underwater = "Underwater"
    case landscape = "Landscape"
    case architecture = "Architecture"
    case gradients = "Gradients"
    
}
