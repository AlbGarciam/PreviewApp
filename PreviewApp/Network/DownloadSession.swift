//
//  Downloadable.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct DownloadSession {
    static func request<Request: DownloadRequest>(_ request: Request, _ completion: Request.DownloadRequestCompletion?) {
        
        let request = request.getRequest()
        let session = URLSession.shared
        
        NSLog("Fetching file from endpoint: \(request.url?.absoluteString ?? "No endpoint")")
        let task = session.downloadTask(with: request) { (file, response, error) in
            let urlString = request.url?.absoluteString ?? "No URL"
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion?(.failure(.unknown(urlString))) ?? ()
            }
            switch statusCode {
            case 200..<300:
                guard let path = file, (response?.expectedContentLength ?? 0) > 0 else {
                    return completion?(.failure(.empty(urlString))) ?? ()
                }
                return completion?(.success(path)) ?? ()
            default:
                let error = DownloadErrorResponse.init(statusCode, error?.localizedDescription ?? "No description", urlString)
                return completion?(.failure(error)) ?? ()
            }
        }
        
        task.resume()
    }
}
