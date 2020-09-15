//
//  SearchService.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

class SearchService {
    
    static let shared = SearchService()
    
    // TODO: - Remove JSON and be more custom and PAGINATION
    
    func fetchSearch(term: String, then completion: @escaping (Photos?, Error?) -> Void) {
        let params: [String: Any] = ["method": APIConstants.photoMethod + APIConstants.Method.search,
                                     "api_key": APIConstants.apiKey,
                                     "tags": term,
                                     "page": 1,
                                     "format": APIConstants.Format.json,
                                     "nojsoncallback": 1]
        FlickrAPI.shared.fetch(model: Photos.self, params: params) { photos, error in
            DispatchQueue.main.async {
                completion(photos, error)
            }
        }
    }
}
