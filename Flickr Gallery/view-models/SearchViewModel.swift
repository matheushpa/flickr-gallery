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

    private var photos: [Photo]?
    private var currentPage: Int?
    private var lastTerm: String?
    weak var delegate: SearchViewModelDelegate?
    
    // TODO: VERIFY THIS
    //    per_page (Optional)
    //    Number of photos to return per page. If this argument is omitted, it defaults to 100. The maximum allowed value is 500.
    // SO, THE IDEA IS TO CHECK PER PAGE, TOTAL OF PAGES AND TOTAL OF PICTURES AND COMPARE
    // then it is possible to check if another request is necessary, in case I got to the end.
    // Example formula: total_of_pages - (current_page * per_page) = new_per_page_value
    // OBS: Apparently per page is not changing, so you should compare only if current page == pages
    
    func getPhotosByTerm(term: String, page: Int) {
        self.verifyActualPageAndSearch(term: term, previousPage: page)
        SearchService.shared.fetchSearch(term: term, page: self.currentPage ?? 0) { [weak self] photos, error in
            if let allPhotos = photos?.photos?.photo {
                if self?.photos == nil {
                    self?.photos = allPhotos
                } else {
                    self?.photos?.append(contentsOf: allPhotos)
                }
                self?.delegate?.requestSuccess()
            } else if let statusCode = error as? URLError, statusCode.errorCode == -1009 {
                self?.delegate?.noConnectionAvailable()
            } else {
                self?.delegate?.requestFailure()
            }
        }
    }
    
    func verifyActualPageAndSearch(term: String, previousPage: Int) {
        if self.currentPage == nil {
            self.currentPage = previousPage
        } else if self.currentPage != previousPage {
            self.currentPage = previousPage + 1
        }
        if self.lastTerm == nil {
            self.lastTerm = term
        } else if self.lastTerm != term {
            self.currentPage = 1
            self.lastTerm = term
            self.photos?.removeAll()
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
        return self.photos?.count ?? 0
    }
    
    func getPhoto(index: Int) -> String {
        if let photo = self.photos?[index], let imageURL = photo.largeSquareImageURL {
            return imageURL
        } else {
            return ""
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.getCurrentTotalOfPhotos() - 1
    }
    
    func getCurrentPage() -> Int {
        return self.currentPage ?? 0
    }
    
    func getCurrentTerm() -> String {
        return self.lastTerm ?? ""
    }
}
