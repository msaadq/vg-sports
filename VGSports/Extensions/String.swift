//
//  String.swift
//  VGSports
//
//  Created by Saad Qureshi on 16/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation

extension String {
    private static let safeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-")

    public func replaceSpecialCharacters() -> String? {
        if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
            let urlComponents = latin.components(separatedBy: String.safeCharacters.inverted)
            let result = urlComponents.filter { $0 != "" }.joined(separator: "-")

            if result.count > 0 {
                return result
            }
        }

        return nil
    }
}
