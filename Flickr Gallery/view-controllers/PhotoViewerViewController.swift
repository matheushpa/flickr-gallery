//
//  PhotoViewerViewController.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 16/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewerViewController: UIViewController {
    
    var imageURL = ""
    
    private lazy var photoImageView: ImageView = {
        let imageView = ImageView()
        imageView.type = PhotoViewerImageView(url: imageURL)
        return imageView
    }()

    private lazy var closeButton: Button = {
        let button = Button(type: .system)
        button.type = DefaultButton(title: kClose)
        button.addTarget(self, action: #selector(closePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPhotoImageView()
        setupCloseButton()
    }
    
    // MARK: - Setup methods
    
    func setupPhotoImageView() {
        view.addSubviews(photoImageView)
        photoImageView.fillSuperview()
    }
    
    func setupCloseButton() {
        view.addSubviews(closeButton)
        closeButton.anchor(top: view.topAnchor,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 16,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: 16))
    }
    
    // MARK: - Action methods
    
    @objc func closePhoto() {
        self.dismiss(animated: true)
    }
}
