//
//  ViewController.swift
//  URLSessionGetEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/21.
//

import UIKit

class ViewController: UIViewController {
    private lazy var service = Service()
    
    private lazy var urlGetButton: CustomButton = {
        return createButton(title: "Get", method: .get, param: "1")
    }()
    
    private lazy var urlPostButton: CustomButton = {
        return createButton(title: "Post", method: .post, param: nil)
    }()
    
    private lazy var urlPutButton: CustomButton = {
        return createButton(title: "Put", method: .put, param: "1")
    }()
    
    private lazy var urlPatchButton: CustomButton = {
        return createButton(title: "Patch", method: .patch, param: "1")
    }()
    
    private lazy var urlDeleteButton: CustomButton = {
        return createButton(title: "Delete", method: .delete, param: "1")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        self.view.addSubview(urlGetButton)
        self.view.addSubview(urlPostButton)
        self.view.addSubview(urlPutButton)
        self.view.addSubview(urlPatchButton)
        self.view.addSubview(urlDeleteButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            urlGetButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            urlGetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            urlGetButton.heightAnchor.constraint(equalToConstant: 100),
            urlGetButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            urlPostButton.topAnchor.constraint(equalTo: urlGetButton.bottomAnchor, constant: 20),
            urlPostButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            urlPostButton.heightAnchor.constraint(equalToConstant: 100),
            urlPostButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            urlPutButton.topAnchor.constraint(equalTo: urlPostButton.bottomAnchor, constant: 20),
            urlPutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            urlPutButton.heightAnchor.constraint(equalToConstant: 100),
            urlPutButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            urlPatchButton.topAnchor.constraint(equalTo: urlPutButton.bottomAnchor, constant: 20),
            urlPatchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            urlPatchButton.heightAnchor.constraint(equalToConstant: 100),
            urlPatchButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            urlDeleteButton.topAnchor.constraint(equalTo: urlPatchButton.bottomAnchor, constant: 20),
            urlDeleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            urlDeleteButton.heightAnchor.constraint(equalToConstant: 100),
            urlDeleteButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc private func doRequest(sender: CustomButton) {
        guard let method = sender.method else { return }
        service.doRequestBy(httpMethod: method, postId: sender.param)
    }
    
    private func createButton(title: String, method: HttpMethodEnum, param: String?) -> CustomButton {
        let button = CustomButton(frame: .zero)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(doRequest(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.method = method
        button.param = param
        return button
    }
}

