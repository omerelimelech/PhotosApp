//
//  PhotosAppNavigation.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

struct PhotosAppNavigation: AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        guard let navigation = navigation as? PhotosNaivgation else {return UIViewController()}
        switch navigation {
        case .bigPhotoPage(let dataSource, let indexPath):
            let bigViewController = BigImageViewController.initialize(data: BigImageViewController.sbData, type: BigImageViewController.self)
            bigViewController.dataSource = dataSource
            bigViewController.indexPath = indexPath
            return bigViewController
        }
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
    
    
}
