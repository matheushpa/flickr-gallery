//
//  Photos.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

struct Photos: Codable {
    
    var photos: PhotoList?
}

struct PhotoList: Codable {
    
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [Photo]?
}

struct Photo: Codable {
    
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var largeSquareImageURL: String? {
        get {
            if let farmCode = farm,
                let serverId = server,
                let photoId = id,
                let photoSecret = secret {
                return "https://farm\(farmCode).staticflickr.com/\(serverId)/\(photoId)_\(photoSecret)_q.jpg"
            }
            return nil
        }
    }
    var largeImageURL: String? {
        get {
            if let farmCode = farm,
                let serverId = server,
                let photoId = id,
                let photoSecret = secret {
                return "https://farm\(farmCode).staticflickr.com/\(serverId)/\(photoId)_\(photoSecret)_b.jpg"
            }
            return nil
        }
    }
}
