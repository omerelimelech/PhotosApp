//
//  PhotosCollectionViewDataSource.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    enum CellType {
        case preview
        case fullView
    }
    
    var currentCellType: CellType = .preview
    var hits: [Hit]?
    
    private var reuseId: String
    
    init(withHits hits: [Hit]?, reuseId: String, cellType type: CellType){
        self.reuseId = reuseId
        self.hits = hits
        self.currentCellType = type
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hits?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        guard let urlString = self.currentCellType == .preview ? self.hits?[indexPath.item].previewURL : self.hits?[indexPath.item].largeImageURL else {return cell}
        cell.setImage(withUrlString: urlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical && (hits?.count ?? 0) > 0 {
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.fotterReusableId, for: indexPath) as? LoadingFooterView
                return footer!
            default:
                return UICollectionReusableView()
            }
            
        }
        return UICollectionReusableView()
    }
    
}
