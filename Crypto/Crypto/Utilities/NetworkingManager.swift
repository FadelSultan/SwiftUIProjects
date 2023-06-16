//
//  NetworkingManagement.swift
//  Crypto
//
//  Created by Fadel on 09/11/1444 AH.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError:LocalizedError {
        case badURLResponse(url:URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] bad response from URL: \(url)"
            case .unknown: return "[⚠️] unknown error occurred"
            }
        }
    }
    
    static func download(url:URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({try handleUrlResponse(output: $0, url: url)})
            .retry(3) // When fail to get data this line while try 3 times after that without success will continue to show the error
            .eraseToAnyPublisher()
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output , url:URL) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion:Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
