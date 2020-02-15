//
//  LoadingFooterView.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



class LoadingFooterView: UICollectionReusableView {
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicator()
    }
    
    func setupActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        addSubview(self.activityIndicator)
        activityIndicator?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        self.activityIndicator?.startAnimating()
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error Loading")
    }
    
}
