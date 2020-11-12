//
//  Label.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 08/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

//import UIKit
//
//protocol LabelProperties {
//
//    var text: String { get set }
//    var font: UIFont { get }
//    var textColor: UIColor { get }
//    var textAlignment: NSTextAlignment { get }
//    var numberOfLines: Int { get }
//}
//
//struct TitleLabel: LabelProperties {
//
//    var text: String
//    var font: UIFont = UIFont(name: kDefaultFont, size: 20) ?? UIFont.systemFont(ofSize: 20)
//    var textColor: UIColor = .black
//    var textAlignment: NSTextAlignment = .center
//    var numberOfLines: Int = 0
//
//    init(title: String) {
//        self.text = title
//    }
//}
//
//struct DescriptionLabel: LabelProperties {
//
//    var text: String
//    var font: UIFont = UIFont(name: kDefaultFont, size: 14) ?? UIFont.systemFont(ofSize: 14)
//    var textColor: UIColor = .black
//    var textAlignment: NSTextAlignment = .center
//    var numberOfLines: Int = 0
//
//    init(title: String) {
//        self.text = title
//    }
//}

import UIKit

protocol LabelProperties {
    
    var text: String { get set }
    var font: UIFont { get set }
    var textColor: UIColor { get set }
    var textAlignment: NSTextAlignment { get set }
    var numberOfLines: Int { get }
}

struct SemiBoldLabel: LabelProperties {

    var text: String
    var textAlignment: NSTextAlignment
    var textColor: UIColor
    var font: UIFont
    var numberOfLines: Int = 0
    
    init(title: String, alignment: NSTextAlignment? = nil, textColor: UIColor? = nil, fontSize: CGFloat? = nil) {
        self.text = title
        self.textAlignment = alignment ?? .center
        self.textColor = textColor ?? .black
        self.font = UIFont(name: kSemiBold, size: fontSize ?? 20) ?? UIFont.systemFont(ofSize: fontSize ?? 20)
    }
}

struct MediumLabel: LabelProperties {

    var text: String
    var textAlignment: NSTextAlignment
    var textColor: UIColor
    var font: UIFont
    var numberOfLines: Int = 0
    
    init(title: String, alignment: NSTextAlignment? = nil, textColor: UIColor? = nil, fontSize: CGFloat? = nil) {
        self.text = title
        self.textAlignment = alignment ?? .center
        self.textColor = textColor ?? .black
        self.font = UIFont(name: kMedium, size: fontSize ?? 14) ?? UIFont.systemFont(ofSize: fontSize ?? 14)
    }
}

struct LightLabel: LabelProperties {

    var text: String
    var textAlignment: NSTextAlignment
    var textColor: UIColor
    var font: UIFont
    var numberOfLines: Int = 0
    
    init(title: String, alignment: NSTextAlignment? = nil, textColor: UIColor? = nil, fontSize: CGFloat? = nil) {
        self.text = title
        self.textAlignment = alignment ?? .center
        self.textColor = textColor ?? .black
        self.font = UIFont(name: kLight, size: fontSize ?? 14) ?? UIFont.systemFont(ofSize: fontSize ?? 14)
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

