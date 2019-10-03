//
//  APIService.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Saad Qureshi. All rights reserved.
//

import Foundation
import Combine

// MARK: - APIService
struct APIService {
    static let shared = APIService()
    
    let baseURL = URL(string: "https://sports-app-code-test.herokuapp.com/")!
    let decoder = JSONDecoder()
    
    // MARK: - Errors
    enum APIError: Error {
        case jsonDecodingError(error: Error)
        case httpError
        case unknownError
    }
    
    // MARK: - End points
    enum Endpoint {
        case events
        case eventDetails(eventId: Int)
        
        func path() -> String {
            switch self {
            case .events:
                return "api/events"
            case let .eventDetails(eventId):
                return "api/events/\(String(eventId))"
            }
        }
    }
    
    // MARK: - GET Request
    func GET<T: Codable>(modelObject: T.Type, endpoint: Endpoint, params: [String: String]?) -> AnyPublisher<T, APIError> {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = []
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.httpError }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{
                if type(of: $0) == Swift.DecodingError.self {
                    return APIError.jsonDecodingError(error: $0)
                }
                return APIError.unknownError
            }
            .eraseToAnyPublisher()
    }
}
