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
    
    var hits: [Hit]?
    
    private var reuseId: String
    
    init(withHits hits: [Hit]?, reuseId: String){
        self.reuseId = reuseId
        self.hits = hits
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hits?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        guard let urlString = self.hits?[indexPath.item].largeImageURL else {return cell}
        cell.setImage(withUrlString: urlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection == .vertical && (hits?.count ?? 0) > 0 {
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.fotterReusableId, for: indexPath)
                let v = UIActivityIndicatorView(style: .gray)
                footer.addSubview(v)
                v.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                }
                v.startAnimating()
                return footer
            default:
                return UICollectionReusableView()
            }
            
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.fotterReusableId, for: indexPath)
    }
    
}
