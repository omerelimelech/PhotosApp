//
//  PhotosNavigation.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation


enum PhotosNaivgation: Navigation {
    case bigPhotoPage(_ dataSource: PhotoCollectionViewDataSource, indexPath: IndexPath)
}
