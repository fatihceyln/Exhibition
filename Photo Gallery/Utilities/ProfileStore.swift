//
//  ProfileStore.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import Foundation

class ProfileStore: ObservableObject {
    @Published var profileModel: ProfileModel = ProfileModel()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("exhibitionUserProfile.data")
    }
    
    static func load() async throws -> ProfileModel {
        do {
            let fileURL = try fileURL()
            
            guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                throw URLError(.badURL)
            }
            
            let profileModel = try JSONDecoder().decode(ProfileModel.self, from: file.availableData)
            
            return profileModel
    
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    static func save(profileModel: ProfileModel) async throws {
        do {
            let data = try JSONEncoder().encode(profileModel)
            let fileURL = try fileURL()
            try data.write(to: fileURL)
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}
