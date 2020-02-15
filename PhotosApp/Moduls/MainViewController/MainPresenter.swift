//
//  MainPresenter.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation


class MainPresenter: BasePresenter {
    
    var delegate: MainDelegate?
    
    let model = MainModel()
    
    init(withDelegate delegate: MainDelegate?){
        self.delegate = delegate
    }
    func getByKeyword(keyword: String, page: Int){
        self.delegate?.mainPresenter(self, didChangeFetchingState: .began)
        self.model.getHitsWithKeyword(keyword: keyword, page: page) { (result) in
            self.delegate?.mainPresenter(self, didChangeFetchingState: .ended)
            self.handleResult(result: result, type: [Hit].self, forKey: Constants.hitsKey, completion: { (hits) in
                if page == 1{
                    self.delegate?.mainPresenter(self, didFetchHits: hits)
                }else{
                    self.delegate?.mainPresenter(self, didFetchHits: hits, forPage: page)
                }
            })
        }
    }
    
    override var error: Error?{
        willSet{
            if newValue != nil {
                self.delegate?.mainPresenter(self, didFailFetchingHitsWith: newValue)
            }
        }
    }
}
