//
//  CacheManager.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 9.07.2022.
//

import Foundation
import SwiftUI

class CacheManager {
    static let shared: CacheManager = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 600
        cache.totalCostLimit = 1024 * 1024 * 500
        return cache
    }() // You have to initialize it, if you don't this won't work.
    
    func addImage(image: UIImage, id: String) {
        imageCache.setObject(image, forKey: id as NSString)
    }
    
    func getImage(id: String) -> UIImage? {
        imageCache.object(forKey: id as NSString)
    }
}
