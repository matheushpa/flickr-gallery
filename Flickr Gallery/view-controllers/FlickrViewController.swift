//
//  FlickrViewController.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController, UISearchBarDelegate {
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: kPhotoCollectionCellIdentifier)
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupLoadingView()
//        setupErrorView(isConnected: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        self.title = "Flickr Gallery"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .white
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.titleView?.tintColor = .yellow
        searchController.hidesNavigationBarDuringPresentation = true
        setupCollectionViewLayout()
        searchViewModel = SearchViewModel()
        searchViewModel.delegate = self
        searchViewModel.getPhotosByTerm(term: "kitten")
//        searchViewModel.getPhotoSizes(photoId: 31456463045) // USE IT IN UNIT TEST
    }
    
    // MARK: - Setup methods
    
    func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.addTopConstraint()
        collectionView.addBottomConstraint()
        collectionView.addLeadingConstraint()
        collectionView.addTrailingConstraint()
    }
    
    func setupLoadingView() {
        loadingView = LoadingView(frame: .zero)
        loadingView.configureView(backgroundColor: .white)
        view.addSubview(loadingView)
        loadingView.addLeadingConstraint()
        loadingView.addTrailingConstraint()
        loadingView.addTopConstraint()
        loadingView.addBottomConstraint()
    }
    
    func setupErrorView(isConnected: Bool, resultIsEmpty: Bool? = nil) {
        collectionView.isHidden = true
//        if cartIsEmpty != nil, cartIsEmpty == true {
//            self.errorView = ErrorView(frame: .zero, noConnection: isConnected, resultIsEmpty: resultIsEmpty)
//        } else {
            self.errorView = ErrorView(frame: .zero, noConnection: isConnected)
//        }
        errorView.configureView(backgroundColor: .white)
        errorView.delegate = self
        view.addSubview(errorView)
        errorView.addLeadingConstraint()
        errorView.addTrailingConstraint()
        errorView.addTopConstraint()
        errorView.addBottomConstraint()
    }
}

extension FlickrViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ErrorViewDelegate, SearchViewModelDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.getCurrentTotalOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionCellIdentifier, for: indexPath) as? PhotoCollectionViewCell {
            cell.bindData(imageURL: searchViewModel.getPhoto(index: indexPath.row))
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    // MARK: - Search View Model delegate
    
    func requestSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func requestFailure() {
    
    }
    
    // MARK: - ErrorView delegate
    
    func refreshStore() {
//        setupLoadingView()
        errorView.removeFromSuperview()
    }
}
