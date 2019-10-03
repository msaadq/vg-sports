//
//  LogoService.swift
//  VGSports
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Saad Qureshi. All rights reserved.
//

import Foundation
import Combine
import UIKit

// MARK: - LogoService
class LogoService {
    static let shared = LogoService()
    
    // MARK: - Logo Sizes
    enum Size: String, Codable {
        case small = "clip-32x32"
        case medium = "clip-56x56"
        case large = "clip-112x112"
        
        func path(imageUrl: String) -> URL {
            return URL(string: imageUrl + "rule=\(rawValue)")!
        }
    }
    
    // MARK: - ImageError
    enum ImageError: Error {
        case decodingError
    }
    
    // MARK: - fetchImage
    func fetchImage(imageUrl: String, size: Size) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: size.path(imageUrl: imageUrl))
            .tryMap { (data, response) -> UIImage? in
                return UIImage(data: data)
        }.catch { error in
            return Just(nil)
        }
        .eraseToAnyPublisher()
    }
}
