//
//  PhotoSizes.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

struct PhotoSizes: Codable {

    var sizes: Size?
}

struct Size: Codable {
    
    var size: [Sizes]?
}

struct Sizes: Codable {
    
    var label: String?
    var source: String?
    var url: String?
    var media: String?
}
