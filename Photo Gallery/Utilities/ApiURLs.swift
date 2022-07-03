//
//  ApiURLs.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation

class ApiURLs {
    static let baseURL: String = "https://api.unsplash.com/"
    
    static func editorial(byPage page: Int) -> String {
        "https://api.unsplash.com/photos?page=\(page)&&per_page=10&&client_id=HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
    }
    
    static func searchBy(name: String) -> String {
        return "https://api.unsplash.com/search/photos?page=1&query=\(name)&&client_id=HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
    }
    
    static let topics: String = "https://api.unsplash.com/topics?per_page=21&&client_id=HVp3fBJ3w1J6VPVIWpCKaz26lbQUkGTGReu9UC1Q0vg"
}

