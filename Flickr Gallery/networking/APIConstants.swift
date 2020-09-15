//
//  APIConstants.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

struct APIConstants {
    
    static let baseURL = "https://api.flickr.com/services/rest/"
    static let apiKey = "f9cc014fa76b098f9e82f1c288379ea1"
    static let photoMethod = "flickr.photos."
    
    struct Method {
        static let search = "search"
        static let size = "getSizes"
    }
    
    struct Format {
        static let json = "json"
    }
}
