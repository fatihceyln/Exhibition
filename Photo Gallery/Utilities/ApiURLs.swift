//
//  ApiURLs.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation

class ApiURLs {
    static let key1 = "nJXLciTieEywZUX30IE76rxti1_GKx1FaS5OE-5MLRQ"
    static let key2 = "ma8Zk0gXKPNNBN9q4m77BG657O7twbtoQY7y2c-2LQs"
    static let key3 = "t1WzXoN8EXln8m6CpZJAhFXrZWsSMdiJ-1qN8yjkgn0"
    static let key4 = "HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
    static let key5 = "qnamd0u9ODrfvksWk7-2gGMgFdGrXzelZasatj9xolc"
    
    static let apiKey: String = key2

    static let randomPhoto: String = "https://api.unsplash.com/photos/random?client_id=\(apiKey)"
    
    static func editorial(byPage page: Int) -> String {
        "https://api.unsplash.com/photos?page=\(page)&&per_page=10&&client_id=\(apiKey)"
    }
    
    // MARK: TOPIC
    static let topics: String = "https://api.unsplash.com/topics?per_page=21&&client_id=\(apiKey)"
    
    static func topicPhoto(topic: TopicEnum, page: Int) -> String {
        return "https://api.unsplash.com/topics/\(topic.topicId)/photos?page=\(page)&&client_id=\(apiKey)"
    }
    
    static func topic(id: String) -> String {
        return "https://api.unsplash.com/topics/\(id)?client_id=HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
    }
    
    // MARK: LIST
    static func ListAPhotosOfUser(username: String, page: Int
    ) -> String {
        return "https://api.unsplash.com/users/\(username)/photos?page=\(page)&&client_id=\(apiKey)"
    }
    
    static func ListAUsersLikedPhotos(username: String, page: Int) -> String {
        return "https://api.unsplash.com/users/\(username)/likes?page=\(page)&&client_id=\(apiKey)"
    }
    
    static func ListAUsersCollections(username: String, page: Int) -> String {
        return "https://api.unsplash.com/users/\(username)/collections?page=\(page)&&client_id=\(apiKey)"
    }
    
    // MARK: SEARCH
    static func searchPhotos(text: String, page: Int) -> String {
        return "https://api.unsplash.com/search/photos?page=\(page)&&query=\(text)&&client_id=\(apiKey)"
    }
    
    static func searchCollections(text: String, page: Int) -> String {
        return "https://api.unsplash.com/search/collections?page=\(page)&&query=\(text)&&client_id=\(apiKey)"
    }
    
    static func searchUsers(text: String, page: Int) -> String {
        return "https://api.unsplash.com/search/users?page=\(page)&&query=\(text)&&client_id=\(apiKey)"
    }
}

