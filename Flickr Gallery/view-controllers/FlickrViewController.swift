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
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        setupLoadingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionViewLayout()
        searchViewModel = SearchViewModel()
//        searchViewModel.getPhotosByTerm(term: "kitten")
        searchViewModel.getPhotoSizes(photoId: 31456463045)
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
}

extension FlickrViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (collectionView.bounds.width / 2) //- 32
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionCellIdentifier, for: indexPath) as? PhotoCollectionViewCell {
            cell.bindData(imageURL: "https://farm6.staticflickr.com/5800/31456463045_5a0af4ddc8_q.jpg")
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}
