//
//  ViewController.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "pdfIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var buttonDownload: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Download File", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(downloadButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonOpenPdf: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Open File", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openPdfButtonClick), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var buttonResume: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Resume", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resumeButtonClick), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Container Views
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isHidden = true
        return containerView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(frame: .zero)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        return spinner
    }()
    
    private lazy var buttonPause: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Pause", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pauseButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonCancel: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Service
    
    private let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureContainerView()
        configureConstraints()
        configureContainerConstraints()
    }
    
    private func configureView() {
        self.view.addSubview(image)
        self.view.addSubview(buttonDownload)
        self.view.addSubview(buttonOpenPdf)
        self.view.addSubview(buttonResume)
        self.view.addSubview(containerView)
        self.view.addSubview(spinner)
    }
    
    private func configureContainerView() {
        containerView.addSubview(buttonCancel)
        containerView.addSubview(buttonPause)
        containerView.addSubview(spinner)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonDownload.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            buttonDownload.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonDownload.heightAnchor.constraint(equalToConstant: 50),
            buttonDownload.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonOpenPdf.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            buttonOpenPdf.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonOpenPdf.heightAnchor.constraint(equalToConstant: 50),
            buttonOpenPdf.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonResume.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            buttonResume.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonResume.heightAnchor.constraint(equalToConstant: 50),
            buttonResume.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureContainerConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: containerView.topAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 50),
            spinner.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonPause.topAnchor.constraint(equalTo: spinner.bottomAnchor),
            buttonPause.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonPause.heightAnchor.constraint(equalToConstant: 50),
            buttonPause.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonCancel.topAnchor.constraint(equalTo: buttonPause.bottomAnchor, constant: 10),
            buttonCancel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonCancel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50),
            buttonCancel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func downloadButtonClick() {
        toggleElementsOnScreen(element: .containerView)
        //self.service.downloadFile()
    }
    
    @objc private func openPdfButtonClick() {
        
    }
    
    @objc private func pauseButtonClick() {
        toggleElementsOnScreen(element: .buttonResume)
    }
    
    @objc private func cancelButtonClick() {
        toggleElementsOnScreen(element: .buttonDownload)
    }
    
    @objc private func resumeButtonClick() {
        toggleElementsOnScreen(element: .containerView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func toggleElementsOnScreen(element: ScreenElement) {
        hideElementsOfScreen()
        switch element {
        case .buttonDownload:
            buttonDownload.isHidden = false
        case .buttonOpenPdf:
            buttonOpenPdf.isHidden = false
        case .buttonResume:
            buttonResume.isHidden = false
        case .containerView:
            containerView.isHidden = false
        }
    }
    
    private func hideElementsOfScreen() {
        buttonDownload.isHidden = true
        buttonOpenPdf.isHidden = true
        buttonResume.isHidden = true
        containerView.isHidden = true
    }
}
