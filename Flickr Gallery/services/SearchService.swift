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
    
    func fetchSearch(term: String, page: Int, then completion: @escaping (Photos?, Error?) -> Void) {
        let params: [String: Any] = ["method": APIConstants.photoMethod + APIConstants.Method.search,
                                     "api_key": APIConstants.apiKey,
                                     "tags": term,
                                     "page": page,
                                     "format": APIConstants.Format.json,
                                     "nojsoncallback": 1]
        FlickrAPI.shared.fetch(model: Photos.self, params: params) { photos, error in
            DispatchQueue.main.async {
                completion(photos, error)
            }
        }
    }
}
