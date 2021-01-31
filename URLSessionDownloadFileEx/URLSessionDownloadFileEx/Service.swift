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
    
    private let urlString = "https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-download-10-mb.pdf"
    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.test.urlSessionDownloadFileEx")
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue: nil)
    }()
    private var delegate: ServiceDelegate?
    private var downloadTask: URLSessionDownloadTask?
    private var resumeData: Data?
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    internal func downloadFile() {
        guard let url = URL(string: urlString) else { return }
        downloadTask = downloadSession.downloadTask(with: url)
        downloadTask?.resume()
    }
    
    internal func pauseDownloadFile() {
        downloadTask?.cancel(byProducingResumeData: { data in
            self.resumeData = data
        })
    }
    
    internal func resumeDownloadFile() {
        guard let resumeData = self.resumeData else { return }
        downloadTask = downloadSession.downloadTask(withResumeData: resumeData)
        downloadTask?.resume()
    }
    
    internal func cancelDownloadFile() {
        downloadTask?.cancel()
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
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didResumeAtOffset fileOffset: Int64,
                    expectedTotalBytes: Int64) {
        guard let originalUrl = downloadTask.originalRequest?.url else { return }
        let destinationPath = localFilePath(for: originalUrl)
        self.delegate?.downloadSuccess(fileURL: destinationPath)
    }
}
