//
//  Label.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 08/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

protocol LabelProperties {
    
    var text: String { get set }
    var font: UIFont { get }
    var textColor: UIColor { get }
    var textAlignment: NSTextAlignment { get }
    var numberOfLines: Int { get }
}

struct TitleLabel: LabelProperties {

    var text: String
    var font: UIFont = UIFont(name: kDefaultFont, size: 20) ?? UIFont.systemFont(ofSize: 20)
    var textColor: UIColor = .black
    var textAlignment: NSTextAlignment = .center
    var numberOfLines: Int = 0
    
    init(title: String) {
        self.text = title
    }
}

struct DescriptionLabel: LabelProperties {
    
    var text: String
    var font: UIFont = UIFont(name: kDefaultFont, size: 14) ?? UIFont.systemFont(ofSize: 14)
    var textColor: UIColor = .black
    var textAlignment: NSTextAlignment = .center
    var numberOfLines: Int = 0
    
    init(title: String) {
        self.text = title
    }
}

class Label: UILabel {
    
    var type: LabelProperties? {
        didSet {
            guard let type = type else { return }
            font = type.font
            textColor = type.textColor
            textAlignment = type.textAlignment
            numberOfLines = type.numberOfLines
            text = type.text
        }
    }
}
