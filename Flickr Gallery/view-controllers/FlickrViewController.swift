//
//  FlickrViewController.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController {
    
    var searchViewModel: SearchViewModel!
    var loadingView: LoadingView!
    var errorView: ErrorView!
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = kCellPadding
        collectionViewLayout.minimumInteritemSpacing = kCellPadding
        collectionViewLayout.sectionInset = UIEdgeInsets(top: kCellPaddingToBorders,
                                                         left: kCellPaddingToBorders,
                                                         bottom: kCellPaddingToBorders,
                                                         right: kCellPaddingToBorders)
        let viewWidth = self.view.bounds.size.width
        let photoSize: CGFloat = (viewWidth - (2 * kCellPaddingToBorders) - (kNumberOfCellsPerRow - 1) * kCellPadding) / kNumberOfCellsPerRow
        collectionViewLayout.itemSize = CGSize(width: photoSize, height: photoSize)
        return collectionViewLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: kPhotoCollectionCellIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupCollectionViewLayout()
        searchViewModel = SearchViewModel()
        searchViewModel.delegate = self
    }
    
    // MARK: - Setup methods
    
    func setupCollectionViewLayout() {
        view.addSubviews(collectionView)
        collectionView.fillSuperview()
    }
    
    func setupLoadingView() {
        loadingView = LoadingView(frame: .zero)
        loadingView.backgroundColor = .white
        view.addSubviews(loadingView)
        loadingView.fillSuperview()
    }
    
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.tintColor = .black
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.titleView?.tintColor = .white
        searchController.hidesNavigationBarDuringPresentation = true
    }
    
    func setupErrorView(isConnected: Bool, resultIsEmpty: Bool? = nil) {
        collectionView.isHidden = true
        if resultIsEmpty != nil, resultIsEmpty == true {
            self.errorView = ErrorView(frame: .zero, noConnection: isConnected, resultIsEmpty: resultIsEmpty)
        } else {
            self.errorView = ErrorView(frame: .zero, noConnection: isConnected)
        }
        errorView.backgroundColor = .white
        errorView.delegate = self
        view.addSubviews(errorView)
        errorView.fillSuperview()
    }
}

extension FlickrViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ErrorViewDelegate, SearchViewModelDelegate, UISearchBarDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.getCurrentTotalOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionCellIdentifier, for: indexPath) as? PhotoCollectionViewCell {
            cell.bindData(imageURL: searchViewModel.getThumbnailPhoto(index: indexPath.row))
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoViewer = PhotoViewerViewController()
        photoViewer.imageURL = searchViewModel.getLargePhoto(index: indexPath.row)
        self.navigationController?.present(photoViewer, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if searchViewModel.isLoadingCell(for: indexPath) {
            let page = searchViewModel.getCurrentPage() + 1
            let term = searchViewModel.getCurrentTerm()
            searchViewModel.getPhotosByTerm(term: term, page: page)
        }
    }
    
    // MARK: - Search View Model delegate
    
    func requestSuccess() {
        loadingView.removeAnimation()
        collectionView.isHidden = false
        collectionView.reloadData()
        if searchViewModel.getCurrentTotalOfPhotos() == 0 {
            setupErrorView(isConnected: true, resultIsEmpty: true)
        } else if errorView != nil {
            errorView.removeFromSuperview()
        }
    }
    
    func requestFailure(isConnected: Bool) {
        loadingView.removeAnimation()
        setupErrorView(isConnected: isConnected)
    }
    
    // MARK: - ErrorView delegate
    
    func refreshSearch() {
        collectionView.isHidden = false
        collectionView.reloadData()
        errorView.removeFromSuperview()
    }
    
    func continueOffline() {
        collectionView.isHidden = false
        errorView.removeFromSuperview()
    }
    
    // MARK: - SearchBar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setupLoadingView()
        if let term = searchBar.text, term.count >= 3 {
            searchViewModel.getPhotosByTerm(term: term, page: 1)
        }
        searchController.isActive = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
