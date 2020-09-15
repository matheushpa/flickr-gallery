//
//  PhotosService.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

class PhotosService {
    
    static let shared = PhotosService()
    
    // TODO: - Remove JSON and be more custom and GET PER PHOTO ID
    
    func fetchPhotoSize(photoId: Int, then completion: @escaping (PhotoSizes?, Error?) -> Void) {
        let params: [String: Any] = ["method": APIConstants.photoMethod + APIConstants.Method.size,
                                     "api_key": APIConstants.apiKey,
                                     "photo_id": photoId,
                                     "format": APIConstants.Format.json,
                                     "nojsoncallback": 1]
        FlickrAPI.shared.fetch(model: PhotoSizes.self, params: params) { sizes, error in
            DispatchQueue.main.async {
                completion(sizes, error)
            }
        }
    }
}
