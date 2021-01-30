//
//  Service.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/01/21.
//

import Foundation

protocol ServiceDelegate {
    func downloadSuccess(fileURL: URL)
    func downloadError(errorMessage: String)
}

final class Service: NSObject {
    
    private let urlString = "https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-file.pdf"
    private lazy var downloadSession: URLSession = {
        return URLSession(configuration: .default,
                          delegate: self,
                          delegateQueue: nil)
    }()
    private var delegate: ServiceDelegate?
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    internal func downloadFile() {
        guard let url = URL(string: urlString) else { return }
        let downloadTask = downloadSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    private func localFilePath(for url: URL) -> URL {
        return DocumentUtils.documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}

extension Service: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        
        guard let originalUrl = downloadTask.originalRequest?.url else { return }
        let destinationPath = localFilePath(for: originalUrl)
        let fileManager = FileManager.default
        do {
            try? fileManager.removeItem(at: destinationPath)
            try fileManager.copyItem(at: location, to: destinationPath)
            DispatchQueue.main.async {
                self.delegate?.downloadSuccess(fileURL: destinationPath)
            }
        } catch let error {
            let errorMessage = "Could not copy file to disk: \(error)"
            DispatchQueue.main.async {
                self.delegate?.downloadError(errorMessage: errorMessage)
            }
        }
    }
}
