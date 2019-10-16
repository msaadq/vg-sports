//
//  DateFormatter.swift
//  VGSports
//
//  Created by Saad Qureshi on 14/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let vgDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
