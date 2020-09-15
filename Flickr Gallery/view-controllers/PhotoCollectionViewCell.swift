//
//  PhotoCollectionViewCell.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 15/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    func setupPhotoImageView() {
        self.addSubview(photoImageView)
        photoImageView.addTopConstraint()
        photoImageView.addBottomConstraint()
        photoImageView.addLeadingConstraint()
        photoImageView.addTrailingConstraint()
    }
    
    func bindData(imageURL: String) {
        photoImageView.sd_setImage(with: URL(string: imageURL),
                                   placeholderImage: UIImage(named: "placeholder"))
    }
}