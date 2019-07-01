//
//  DownloadRequest.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

enum Methods: String, Codable {
    case GET
}

protocol DownloadRequest {
    
    typealias DownloadRequestResponse = Result<URL, DownloadErrorResponse>
    typealias DownloadRequestCompletion = (DownloadRequestResponse) -> ()
    
    var method: Methods { get }
    var url: URL { get }
    var headers: [String:String] { get }
    
}

extension DownloadRequest {
    var headers: [String:String] { return [:] }
    
    func getRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func makeRequest(completion: DownloadRequestCompletion?) {
        DownloadSession.request(self, completion)
    }
}
