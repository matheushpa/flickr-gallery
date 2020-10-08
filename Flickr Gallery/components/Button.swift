//
//  Button.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 08/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

protocol ButtonProperties {
    
    var text: NSAttributedString { get set }
    var font: UIFont { get }
    var tintColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var cornerRadius: CGFloat { get }
}

struct DefaultButton: ButtonProperties {

    var tintColor: UIColor = UIColor.init(netHex: kBlueColor)
    var font: UIFont = UIFont(name: kDefaultFont, size: 16) ?? UIFont.systemFont(ofSize: 16)
    var backgroundColor: UIColor = .clear
    var cornerRadius: CGFloat = 0
    var text: NSAttributedString
    
    init(title: String) {
        self.text = NSAttributedString(string: title,
                                        attributes: [
                                            NSAttributedString.Key.foregroundColor: self.tintColor,
                                            NSAttributedString.Key.font: self.font as Any])
    }
}

struct LargeButton: ButtonProperties {
    
    var tintColor: UIColor = UIColor.white
    var font: UIFont = UIFont(name: kDefaultFont, size: 16) ?? UIFont.systemFont(ofSize: 16)
    var backgroundColor: UIColor = UIColor.init(netHex: kBlueColor)
    var cornerRadius: CGFloat = 4
    var text: NSAttributedString
    
    init(title: String) {
        self.text = NSAttributedString(string: title,
                                        attributes: [
                                            NSAttributedString.Key.foregroundColor: self.tintColor,
                                            NSAttributedString.Key.font: self.font as Any])
    }
}

class Button: UIButton {
    
    var type: ButtonProperties? {
        didSet {
            guard let type = type else { return }
            tintColor = type.tintColor
            backgroundColor = type.backgroundColor
            layer.cornerRadius = type.cornerRadius
            setAttributedTitle(type.text, for: .normal)
        }
    }
}
