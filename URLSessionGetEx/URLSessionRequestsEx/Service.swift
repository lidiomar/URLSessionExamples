//
//  Service.swift
//  URLSessionGetEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/21.
//

import Foundation

final class Service: NSObject {
    private let scheme = "https"
    private let host = "jsonplaceholder.typicode.com"
    
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    private func getUrlComponentsFor(postId: String?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = getPath(postId: postId)
        
        return urlComponents
    }
    
    private func getPath(postId: String?) -> String {
        guard let postId = postId else { return "/posts" }
        return "/posts/\(postId)"
    }
    
    internal func doRequestBy(httpMethod: HttpMethodEnum, postId: String?) {
        let urlComponents = getUrlComponentsFor(postId: postId)
        guard let url = urlComponents.url else { return }
        
        var serviceRequest = URLRequest(url: url)
        serviceRequest.httpMethod = httpMethod.rawValue
        
        let dataTask = urlSession.dataTask(with: serviceRequest)
        dataTask.resume()
    }
}

extension Service: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse,
              (200...299) ~= response.statusCode else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Error:\(String(describing: error))" )
    }
}

