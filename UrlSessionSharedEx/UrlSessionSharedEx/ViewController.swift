//
//  ViewController.swift
//  UrlSessionSharedEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let uiButton = UIButton(frame: .zero)
        uiButton.setTitle("Call url", for: .normal)
        uiButton.addTarget(self, action: #selector(makeServerCall), for: .touchUpInside)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.backgroundColor = .gray
        uiButton.layer.cornerRadius = 5
        return uiButton
    }()
    
    private lazy var textView: UITextView = {
        let uiTextView = UITextView(frame: .zero)
        uiTextView.isScrollEnabled = true
        uiTextView.translatesAutoresizingMaskIntoConstraints = false
        uiTextView.isEditable = false
        return uiTextView
    }()
    
    private var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        self.view.addSubview(button)
        self.view.addSubview(textView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    @objc private func makeServerCall() {
        print("server call")
        service.callURL { jsonString in
            self.textView.text = jsonString
        }
    }
}

