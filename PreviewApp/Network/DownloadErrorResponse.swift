//
//  DownloadErrorResponse.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

class DownloadErrorResponse : Error {
    var url: String
    var statusCode: Int
    var message: String
    
    init(_ statusCode: Int, _ message: String, _ url: String) {
        (self.url, self.statusCode, self.message) = (url, statusCode, message)
    }
}

extension DownloadErrorResponse {
    static func network(_ url: String) -> DownloadErrorResponse {
        return DownloadErrorResponse(-1, "Network connection error", url)
    }
    
    static func unknown(_ url: String) -> DownloadErrorResponse {
        return DownloadErrorResponse(-2, "Unknown error", url)
    }
    
    static func empty(_ url: String) -> DownloadErrorResponse {
        return DownloadErrorResponse(-3, "Empty data", url)
    }
}

extension DownloadErrorResponse: Equatable {
    static func == (lhs: DownloadErrorResponse, rhs: DownloadErrorResponse) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}
