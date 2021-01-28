//
//  Service.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/01/21.
//

import Foundation

final class Service: NSObject {
    
    private let urlString = "https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-file.pdf"
    
    private lazy var downloadSession: URLSession = {
        return URLSession(configuration: .default,
                          delegate: self,
                          delegateQueue: nil)
    }()
    
    internal func downloadFile() {
        guard let url = URL(string: urlString) else { return }
        let downloadTask = downloadSession.downloadTask(with: url)
        downloadTask.resume()
    }
}

extension Service: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Location: \(location)")
    }
}
