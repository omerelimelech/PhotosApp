//
//  BigImageViewController.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



class BigImageViewController : BaseViewController {
    
    static let sbData: sbData = (Constants.mainStoryboardId, Constants.bigViewControllerStoryboardId)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: PhotoCollectionViewDataSource?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource?.currentCellType = .fullView
        collectionView.register(UINib(nibName: MainCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let indexPath = self.indexPath else {return}
        // scroll to item when collectionview is done reloading
        collectionView.performBatchUpdates(nil) { (done) in
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataSource?.currentCellType = .preview
    }
    
   
}

// MARK: Collection view delegate flow layout

extension BigImageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
