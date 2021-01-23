//
//  Service.swift
//  UrlSessionSharedEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/21.
//

import Foundation

final class Service {
    private let urlSession = URLSession.shared
    
    internal func callURL(completion: ((String)->Void)?) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print("Error")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299) ~= response.statusCode else {
                print("Invalid code")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let completion = completion else { return }
                    
                    DispatchQueue.main.async {
                        completion("\(json)")
                    }
                } catch {
                    print("Json error")
                }
            }
        }
        dataTask.resume()
    }
}
