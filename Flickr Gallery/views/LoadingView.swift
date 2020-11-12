//
//  LoadingView.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 15/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    private lazy var lottieAnimation: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("loading", bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLoadingAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setop methods
    
    func setupLoadingAnimation() {
        self.addSubviews(lottieAnimation)
        lottieAnimation.addSize(width: 100, height: 100)
        lottieAnimation.centerView()
        lottieAnimation.play()
    }
    
    // MARK: - Action methods
    
    public func removeAnimation() {
        lottieAnimation.pause()
        self.removeFromSuperview()
    }
}
