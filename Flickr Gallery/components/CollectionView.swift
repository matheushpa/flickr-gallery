//
//  CollectionView.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 13/10/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

class CollectionView<T, Cell: UICollectionViewCell>: UICollectionView {

    var items: [T]
    var configure: (Cell, T) -> Void
    var selectHandler: (T) -> Void
    var cellIdentifier: String

    init(frame: CGRect, layout: UICollectionViewLayout, items: [T], identifier: String, configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        self.cellIdentifier = identifier
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(Cell.self, forCellWithReuseIdentifier: identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? Cell {
            let item = items[indexPath.row]
            configure(cell, item)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectHandler(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}
