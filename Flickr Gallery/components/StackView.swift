//
//  StackView.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 08/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

protocol StackViewProperties {
    
    var spacing: CGFloat { get set }
    var axis: NSLayoutConstraint.Axis { get }
}

struct VerticalStackView: StackViewProperties {
    
    var spacing: CGFloat
    var axis: NSLayoutConstraint.Axis = .vertical
    
    init(spacing: CGFloat? = nil) {
        self.spacing = spacing ?? 16
    }
}

struct HorizontalStackView: StackViewProperties {
    
    var spacing: CGFloat
    var axis: NSLayoutConstraint.Axis = .horizontal
    
    init(spacing: CGFloat? = nil) {
        self.spacing = spacing ?? 8
    }
}

class StackView: UIStackView {

    var type: StackViewProperties? {
        didSet {
            guard let type = type else { return }
            spacing = type.spacing
            axis = type.axis
        }
    }
}

