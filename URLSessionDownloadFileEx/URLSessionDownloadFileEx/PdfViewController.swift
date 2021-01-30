//
//  PdfViewController.swift
//  URLSessionDownloadFileEx
//
//  Created by Lidiomar Fernando dos Santos Machado on 30/01/21.
//

import Foundation
import UIKit
import PDFKit

class PdfViewController: UIViewController {
    
    private lazy var pdfView: PDFView = {
        let pdfView = PDFView(frame: .zero)
        pdfView.autoScales = true
        pdfView.isUserInteractionEnabled = true
        pdfView.backgroundColor = .gray
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        return pdfView
    }()
    
    internal var urlDocument: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configurePDFView()
    }
    
    private func configureViews() {
        self.view.backgroundColor = .gray
        self.view.addSubview(pdfView)
    }
    
    private func configurePDFView() {
        guard let urlDocument = self.urlDocument else { return }
        configurePDFConstraints()
        pdfView.document = PDFDocument(url: urlDocument)
    }
    
    private func configurePDFConstraints() {
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            pdfView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
