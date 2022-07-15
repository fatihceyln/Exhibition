//
//  ApiURLs.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation

class ApiURLs {
    static let key1 = "Ui7YxWIn_nz4Q0xQkf_8TGZherKgc-RjDxnEJIRjBEo"
    static let key2 = "lBHYg0B8GpBTXcVCK6gejOoZV09ERrZhZApaERpqfIs"
    static let key3 = "Dv8B7hG6iSq5B3ODoAyRryGyd70KSn703uqa6dMO85o"
    static let key4 = "Ar67sXJBHLFYhDW7CQTsIl68JCjPi43GkOfUywYpmR0"
    static let key5 = "xwgA3MYYzvAPe37zMtEaq1_K_i2L26LiJCoE7AkRdBE"
    static let key6 = "TmS6Omp8oUt4pSEZyBXD7McD2y4enqv-LwiW7aVaMwQ"
    static let key7 = "CfNvZ6l0EAlHZaz28AsL_yaoA5LNljYgN1zgZTq58nk"
    static let key8 = "8zGUTt9KU0JGgG0-cwrY6xlod9HCicXJ52J-vX5I7I0"
    static let key9 = "KUZqqo3FQR5FEmurFornb9R4gREoLAyEhHL8rZ1DJ8Q"
    static let key10 = "IIolUW7rlPbjdWBSIheAcC5_3YH13yvtOVz05GRT1iI"
    static let key11 = "x2qp6-y3jM-0jSniRFlw-RvGGmgWOTSFIHSnE1wDYvk"
    
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
        return "https://api.unsplash.com/topics/\(id)?client_id=\(apiKey)"
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

