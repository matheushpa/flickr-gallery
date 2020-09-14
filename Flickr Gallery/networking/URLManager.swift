//
//  URLManager.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit



class URLManager {
    
    static let shared = URLManager()
    private var urls: [String: URL] = [:]
    
    private init() {
        if let url = Bundle.main.url(forResource: "urls", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let urls = try JSONDecoder().decode([String: URL].self, from: data)
                self.urls = urls
            } catch {
                print("Can't find urls.json!")
            }
        }
    }
    
    subscript(key: String) -> URL? {
        return urls[key]
    }
}
