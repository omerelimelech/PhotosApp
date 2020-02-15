//
//  SearchBarDelegate.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation

protocol SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, didEndEditingWithText text: String?)
}
