//
//  MainModel.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation

class MainModel {
    
    func getHitsWithKeyword(keyword: String, page: Int, completion: @escaping completion){
        APIManager.shared.getByQuery(keyword: keyword, page: page, completion: completion)
    }
    
}
