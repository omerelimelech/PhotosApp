//
//  BigImageViewController.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



class BigImageViewController : BaseViewController, UICollectionViewDelegateFlowLayout {
    
    static let sbData: sbData = (Constants.mainStoryboardId, Constants.bigViewControllerStoryboardId)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: PhotoCollectionViewDataSource?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: MainCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let indexPath = self.indexPath else {return}
        collectionView.performBatchUpdates({
            
        }) { (b) in
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
