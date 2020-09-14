//
//  JSONDecoder.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()
}
