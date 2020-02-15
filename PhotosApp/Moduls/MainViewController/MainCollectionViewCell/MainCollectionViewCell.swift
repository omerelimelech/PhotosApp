//
//  MainCollectionViewCell.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import UIKit
import SnapKit


class MainCollectionViewCell: UICollectionViewCell {

    static let reuseId = "MainCollectionViewCell"
    
    var imageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(withUrlString urlString: String) {
        guard let url = URL(string: urlString) else {return}
        imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url)
    }

}
