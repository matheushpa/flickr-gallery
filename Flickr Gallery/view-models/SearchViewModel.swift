//
//  SearchViewModel.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    private var photos: Photos?
    
    // TODO: Improve this error and response checking later
    
    func getPhotosByTerm(term: String) {
        SearchService.shared.fetchSearch(term: term) { [weak self] photos, error in
            if let photoList = photos {
                
            } else if let errorStatus = error {
                
            } else {
                
            }
            print(photos)
            print(error)
        }
    }
}
