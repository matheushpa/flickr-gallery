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
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        let buttonAttributedTitle = NSAttributedString(string: kClose,
                                                       attributes: [
                                                        NSAttributedString.Key.foregroundColor: UIColor.init(netHex: kBlueColor),
                                                        NSAttributedString.Key.font: UIFont(name: kDefaultFont, size: 16) as Any])
        button.setAttributedTitle(buttonAttributedTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(photoImageView)
        photoImageView.fillSuperview()
        photoImageView.sd_setImage(with: URL(string: imageURL),
                                   placeholderImage: UIImage(named: "placeholder"))
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16))
    }
    
    // MARK: - Action methods
    
    @objc func closePhoto() {
        self.dismiss(animated: true)
    }
}
