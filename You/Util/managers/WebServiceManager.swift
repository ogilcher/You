//
//  WebService.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

// This class is used for API calling

import SwiftUI

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

final class WebServiceManager {
    static let shared = WebServiceManager() // Singleton instance
    private init() {} // Prevents direct instantiation

    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
}
