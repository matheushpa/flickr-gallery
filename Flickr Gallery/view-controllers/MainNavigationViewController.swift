//
//  MainNavigationViewController.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 15/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    private let galleryViewController = FlickrViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewControllers = [galleryViewController]
    }
    
    // MARK: - Setup methods
    
    func setupNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.init(netHex: kBlueColor)
        navigationBar.barTintColor = UIColor.init(netHex: kBlueColor)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16) as Any]
    }
}
