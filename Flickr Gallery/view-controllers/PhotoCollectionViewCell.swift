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
    
    private lazy var photoImageView: ImageView = {
        let imageView = ImageView()
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
        self.addSubviews(photoImageView)
        photoImageView.fillSuperview()
    }
    
    func bindData(imageURL: String) {
        photoImageView.type = GalleryImageView(url: imageURL)
    }
}
