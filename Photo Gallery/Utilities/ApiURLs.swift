//
//  ApiURLs.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation

class ApiURLs {
    
    static let apiKey: String = "nJXLciTieEywZUX30IE76rxti1_GKx1FaS5OE-5MLRQ"

    static let randomPhoto: String = "https://api.unsplash.com/photos/random?client_id=\(apiKey)"
    
    static func editorial(byPage page: Int) -> String {
        "https://api.unsplash.com/photos?page=\(page)&&per_page=10&&client_id=\(apiKey)"
    }
    
    static func searchBy(name: String) -> String {
        return "https://api.unsplash.com/search/photos?page=1&query=\(name)&&client_id=\(apiKey)"
    }
    
    static let topics: String = "https://api.unsplash.com/topics?per_page=21&&client_id=\(apiKey)"
    
    static func topicPhoto(topic: TopicEnum, page: Int) -> String {
        return "https://api.unsplash.com/topics/\(topic.topicId)/photos?page=\(page)&&client_id=\(apiKey)"
    }
    
    static func topic(id: String) -> String {
        return "https://api.unsplash.com/topics/\(id)?client_id=HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
    }
}

