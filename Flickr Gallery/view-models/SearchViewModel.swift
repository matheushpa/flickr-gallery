//
//  SearchViewModel.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    func requestFailure(isConnected: Bool)
    func requestSuccess()
}

class SearchViewModel {

    private var totalPages = 1
    private var photos: [Photo]?
    private var currentPage = 1
    private var lastTerm: String?
    weak var delegate: SearchViewModelDelegate?
    
    func getPhotosByTerm(term: String, page: Int) {
        self.verifyActualPageAndSearch(term: term, previousPage: page)
        if currentPage <= totalPages {
            SearchService.shared.fetchSearch(term: term, page: self.currentPage) { [weak self] photos, error in
                if let pages = photos?.photos?.pages {
                    self?.totalPages = pages
                }
                if let allPhotos = photos?.photos?.photo {
                    if self?.photos == nil {
                        self?.photos = allPhotos
                    } else {
                        self?.photos?.append(contentsOf: allPhotos)
                    }
                    self?.delegate?.requestSuccess()
                } else if let statusCode = error as? URLError, statusCode.errorCode == -1009 {
                    self?.delegate?.requestFailure(isConnected: false)
                } else {
                    self?.delegate?.requestFailure(isConnected: true)
                }
            }
        }
    }
    
    func verifyActualPageAndSearch(term: String, previousPage: Int) {
        if self.currentPage != previousPage {
            self.currentPage += 1
        }
        if self.lastTerm == nil {
            self.lastTerm = term
        } else if self.lastTerm != term {
            self.currentPage = 1
            self.totalPages = 1
            self.lastTerm = term
            self.photos?.removeAll()
        }
    }

    func getPhotoSizes(photoId: Int) {
        PhotosService.shared.fetchPhotoSize(photoId: photoId) { [weak self] sizes, error in
            if let photoSizes = sizes {
                print(photoSizes)
            } else if let statusCode = error as? URLError, statusCode.errorCode == -1009 {
                self?.delegate?.requestFailure(isConnected: false)
            } else {
                self?.delegate?.requestFailure(isConnected: true)
            }
        }
    }
    
    func getCurrentTotalOfPhotos() -> Int {
        return self.photos?.count ?? 0
    }
    
    func getThumbnailPhoto(index: Int) -> String {
        if let isIndexValid = self.photos?.indices.contains(index), isIndexValid {
            return self.photos?[index].largeSquareImageURL ?? ""
        } else {
            return ""
        }
    }
    
    func getLargePhoto(index: Int) -> String {
        if let isIndexValid = self.photos?.indices.contains(index), isIndexValid {
            return self.photos?[index].largeImageURL ?? ""
        } else {
            return ""
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.getCurrentTotalOfPhotos() - 1
    }
    
    func getCurrentPage() -> Int {
        return self.currentPage
    }
    
    func getCurrentTerm() -> String {
        return self.lastTerm ?? ""
    }
}
