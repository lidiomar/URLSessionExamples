//
//  ViewController.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/01/21.
//

import UIKit
import AVKit

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
        button.addTarget(self, action: #selector(openButtonPDFClick), for: .touchUpInside)
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
    
    private lazy var errorMessage: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(16)
        label.isHidden = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
    
    private lazy var service: Service = {
        return Service(delegate: self)
    }()
    
    private var urlDocument: URL?
    
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
        self.view.addSubview(errorMessage)
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
        
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            errorMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
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
            buttonPause.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonPause.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonPause.heightAnchor.constraint(equalToConstant: 50),
            buttonPause.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonCancel.topAnchor.constraint(equalTo: buttonPause.bottomAnchor, constant: 10),
            buttonCancel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50),
            buttonCancel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: buttonCancel.bottomAnchor, constant: 10),
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 50),
            spinner.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func downloadButtonClick() {
        toggleElementsOnScreen(element: .containerView)
        self.service.downloadFile()
    }
    
    @objc private func openButtonPDFClick() {
        let pdfViewController = PdfViewController()
        pdfViewController.urlDocument = self.urlDocument
        self.present(pdfViewController, animated: true, completion: nil)
    }
    
    @objc private func openButtonPlayerClick() {
        guard let url = self.urlDocument else { return }
        let playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true, completion: nil)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    @objc private func pauseButtonClick() {
        service.pauseDownloadFile()
        toggleElementsOnScreen(element: .buttonResume)
    }
    
    @objc private func cancelButtonClick() {
        service.cancelDownloadFile()
        toggleElementsOnScreen(element: .buttonDownload)
    }
    
    @objc private func resumeButtonClick() {
        service.resumeDownloadFile()
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
        case .errorMessage:
            errorMessage.isHidden = false
        }
    }
    
    private func hideElementsOfScreen() {
        buttonDownload.isHidden = true
        buttonOpenPdf.isHidden = true
        buttonResume.isHidden = true
        containerView.isHidden = true
    }
    
    private func showErrorMessage(message: String) {
        errorMessage.text = message
        toggleElementsOnScreen(element: .errorMessage)
    }
}

extension ViewController: ServiceDelegate {
    func downloadSuccess(fileURL: URL) {
        self.urlDocument = fileURL
        toggleElementsOnScreen(element: .buttonOpenPdf)
    }
    
    func downloadError(errorMessage: String) {
        showErrorMessage(message: errorMessage)
    }
}
