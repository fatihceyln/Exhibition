//
//  NetworkingManager.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    static let shared: NetworkingManager = NetworkingManager()
    
    private init() {}
    
    func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    
                    throw(URLError(.badServerResponse))
                }
                
                return data
            }
            .retry(3)
            .eraseToAnyPublisher()
    }
}
