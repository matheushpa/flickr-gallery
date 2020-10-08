//
//  ImageView.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 08/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit
import SDWebImage

protocol ImageViewProperties {
    
    var url: String { get set }
    var cornerRadius: CGFloat { get }
    var clipToBounds: Bool { get }
    var contentMode: UIView.ContentMode { get }
}

struct GalleryImageView: ImageViewProperties {
    
    var url: String
    var cornerRadius: CGFloat = 12
    var clipToBounds: Bool = true
    var contentMode: UIView.ContentMode = .scaleAspectFill
    
    init(url: String) {
        self.url = url
    }
}

struct PhotoViewerImageView: ImageViewProperties {
    
    var url: String
    var cornerRadius: CGFloat = 0
    var clipToBounds: Bool = true
    var contentMode: UIView.ContentMode = .scaleAspectFit
    
    init(url: String) {
        self.url = url
    }
}

class ImageView: UIImageView {

    var type: ImageViewProperties? {
        didSet {
            guard let type = type else { return }
            layer.cornerRadius = type.cornerRadius
            clipsToBounds = type.clipToBounds
            contentMode = type.contentMode
            sd_setImage(with: URL(string: type.url),
                        placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
