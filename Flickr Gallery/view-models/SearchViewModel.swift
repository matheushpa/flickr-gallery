//
//  SearchViewModel.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
//    func authorizationDenied()
//    func noConnectionAvailable()
    func requestFailure()
    func requestSuccess()
}

class SearchViewModel {
    
    private var photos: PhotoList?
    private var currentPhotosPerPage = 0
    weak var delegate: SearchViewModelDelegate?
    
    // TODO: Improve this error and response checking later
    
    func getPhotosByTerm(term: String) {
        SearchService.shared.fetchSearch(term: term) { [weak self] photos, error in
            if let photoList = photos {
                self?.photos = photoList.photos
                self?.delegate?.requestSuccess()
            } else if let errorStatus = error {
                print(errorStatus)
                self?.delegate?.requestFailure()
            } else {
                print(error)
                print(photos)
            }
        }
    }

    func getPhotoSizes(photoId: Int) {
        PhotosService.shared.fetchPhotoSize(photoId: photoId) { [weak self] sizes, error in
            if let photoSizes = sizes {
                
            } else if let errorStatus = error {
                print(errorStatus)
            } else {
                print(sizes)
                print(error)
            }
        }
    }
    
    func getCurrentTotalOfPhotos() -> Int {
        self.currentPhotosPerPage += (self.photos?.perpage ?? 0)
        return currentPhotosPerPage
    }
    
    func getPhoto(index: Int) -> String {
        if let photo = self.photos?.photo?[index].largeSquareImageURL {
            return photo
        } else {
            return ""
        }
    }
}
