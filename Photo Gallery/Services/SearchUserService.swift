//
//  SearchUserService.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 11.07.2022.
//

import Foundation
import Combine

class SearchUserService {
    @Published var users: [User] = []
    var searchText: String = ""
    private var page: Int = 1
    private var cancellable: AnyCancellable? = nil
    
    func downloadSearchResult() {
        guard let url = URL(string: ApiURLs.searchUsers(text: searchText, page: page)) else {return}
        
        page += 1
        
        cancellable = NetworkingManager.shared.download(url: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .decode(type: SearchUser.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { [weak self] returnedSearchUsers in
                if let returnedUsers = returnedSearchUsers.users {
                    self?.users = returnedUsers
                }
                self?.cancellable?.cancel()
            })
    }
}
