//
//  DateFormatter+AssetFormat.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 04/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let assetFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()
}
