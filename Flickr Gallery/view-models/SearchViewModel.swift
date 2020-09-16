//
//  SearchViewModel.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    func noConnectionAvailable()
    func requestFailure()
    func requestSuccess()
}

class SearchViewModel {
    
    private var photos: PhotoList?
    private var currentPhotosPerPage = 0
    weak var delegate: SearchViewModelDelegate?
    
    func getPhotosByTerm(term: String) {
        SearchService.shared.fetchSearch(term: term) { [weak self] photos, error in
            if let photoList = photos {
                self?.photos = photoList.photos
                self?.delegate?.requestSuccess()
            } else if let statusCode = error as? URLError, statusCode.errorCode == -1009 {
                self?.delegate?.noConnectionAvailable()
            } else {
                self?.delegate?.requestFailure()
            }
        }
    }

    func getPhotoSizes(photoId: Int) {
        PhotosService.shared.fetchPhotoSize(photoId: photoId) { [weak self] sizes, error in
            if let photoSizes = sizes {
                print(photoSizes)
            } else if let statusCode = error as? URLError, statusCode.errorCode == -1009 {
                self?.delegate?.noConnectionAvailable()
            } else {
                self?.delegate?.requestFailure()
            }
        }
    }
    
    func getCurrentTotalOfPhotos() -> Int {
//        self.currentPhotosPerPage += (self.photos?.perpage ?? 0)
//        return currentPhotosPerPage
        return self.photos?.photo?.count ?? 0
    }
    
    func getPhoto(index: Int) -> String {
        if let photo = self.photos?.photo?[index], let imageURL = photo.largeSquareImageURL {
            return imageURL
        } else {
            return ""
        }
    }
}
