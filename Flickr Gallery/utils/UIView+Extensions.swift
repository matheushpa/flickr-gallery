//
//  UIView+Extensions.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 15/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Setup views
    
    func configureView(backgroundColor: UIColor, cornerRadius: CGFloat? = nil) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    // MARK: - Constraints
    
    func addConstraintToCenterVertically(constant: CGFloat? = nil) {
        addConstraint(attribute: .centerY,
                      relatedBy: .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: .centerY,
                      multiplier: 1.0,
                      constant: constant ?? 0)
    }
    
    func addConstraintToCenterHorizontally(constant: CGFloat? = nil) {
        addConstraint(attribute: .centerX,
                      relatedBy: .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: .centerX,
                      multiplier: 1.0,
                      constant: constant ?? 0)
    }
    
    func addHeightConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, constant: CGFloat) {
        addConstraint(attribute: .height,
                      relatedBy: relatedBy ?? .equal,
                      parentViewAttributeAnchor: .notAnAttribute,
                      multiplier: 1.0,
                      constant: constant)
    }
    
    func addWidthConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, constant: CGFloat) {
        addConstraint(attribute: .width,
                      relatedBy: relatedBy ?? .equal,
                      parentViewAttributeAnchor: .notAnAttribute,
                      multiplier: 1.0,
                      constant: constant)
    }
    
    func addTopConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, parentViewAttributeAnchor: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
        addConstraint(attribute: .top,
                      relatedBy: relatedBy ?? .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: parentViewAttributeAnchor ?? .top,
                      multiplier: multiplier ?? 1.0,
                      constant: constant ?? 0)
    }
    
    func addBottomConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, parentViewAttributeAnchor: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
        addConstraint(attribute: .bottom,
                      relatedBy: relatedBy ?? .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: parentViewAttributeAnchor ?? .bottom,
                      multiplier: multiplier ?? 1.0,
                      constant: constant ?? 0)
    }
    
    func addLeadingConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, parentViewAttributeAnchor: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
        addConstraint(attribute: .leading,
                      relatedBy: relatedBy ?? .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: parentViewAttributeAnchor ?? .leading,
                      multiplier: multiplier ?? 1.0,
                      constant: constant ?? 0)
    }
    
    func addTrailingConstraint(relatedBy: NSLayoutConstraint.Relation? = nil, parentViewAttributeAnchor: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
        addConstraint(attribute: .trailing,
                      relatedBy: relatedBy ?? .equal,
                      toItem: self.superview,
                      parentViewAttributeAnchor: parentViewAttributeAnchor ?? .trailing,
                      multiplier: multiplier ?? 1.0,
                      constant: constant ?? 0)
    }
    
    func addConstraint(attribute: NSLayoutConstraint.Attribute, relatedBy: NSLayoutConstraint.Relation, toItem: UIView? = nil, parentViewAttributeAnchor: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relatedBy,
                                            toItem: toItem,
                                            attribute: parentViewAttributeAnchor,
                                            multiplier: multiplier,
                                            constant: constant)
        self.superview?.addConstraint(constraint)
    }
}

extension UIStackView {
    
    func configureStackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis) {
        self.spacing = spacing
        self.axis = axis
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
