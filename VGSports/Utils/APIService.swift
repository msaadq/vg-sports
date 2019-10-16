//
//  APIService.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Saad Qureshi. All rights reserved.
//

import Foundation
import Combine
import UIKit

// MARK: - APIService
class APIService {
    
    // MARK: - Public API
    static let shared = APIService()

    static let baseURL = URL(string: "https://sports-app-code-test.herokuapp.com/")!
    let decoder = JSONDecoder()

    // MARK: - Errors
    enum APIError: Error {
        case decodingError
        case httpError
        case unknownError(error: Error)
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

    // MARK: - Logo Sizes
    enum LogoSize: String, Codable {
        case small = "clip-32x32"
        case medium = "clip-56x56"
        case large = "clip-112x112"
    }

    // MARK: - URL Request Mapper
    func getAPIResponseMapper<T: Codable>(modelObject: T.Type, baseURL: URL? = baseURL, endpoint: Endpoint, params: [String: String]? = nil) -> AnyPublisher<T, APIService.APIError> {
        let queryURL = baseURL!.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = []
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        return getRemoteDataPublisher(url: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                if type(of: error) == Swift.DecodingError.self {
                    print("JSON decoding error")
                    return APIError.decodingError
                }
                return APIError.unknownError(error: error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Logo Image Fetcher
    func getLogoImageFetcher(imageUrl: String, size: LogoSize) -> AnyPublisher<UIImage, Never> {
        var components = URLComponents(url: URL(string: imageUrl)!, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "rule", value: size.rawValue)]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        return getRemoteDataPublisher(url: request)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    print("Image decoding error")
                    throw APIError.decodingError
                }
                return image
            }
            .replaceError(with: UIImage(named: "FailedPlaceholder")!)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    // MARK: - Private URL Request Publisher
    private func getRemoteDataPublisher(url: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        .retry(3)
        .tryMap { data, response -> Data in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("HTTP Error")
                throw APIError.httpError
            }
            return data
        }
        .mapError { error in
            print(error.localizedDescription)
            return APIError.unknownError(error: error)
        }
        .eraseToAnyPublisher()
    }
}
