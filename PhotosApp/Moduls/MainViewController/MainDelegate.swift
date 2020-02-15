//
//  MainDelegate.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation

enum FetchingState{
    case began
    case ended
}

protocol MainDelegate {
    func mainPresenter(_ presenter: MainPresenter, didChangeFetchingState state: FetchingState)
    func mainPresenter(_ presenter: MainPresenter, didFetchHits hits: [Hit]?)
    func mainPresenter(_ presenter: MainPresenter, didFetchHits hits: [Hit]?, forPage page: Int)
    func mainPresenter(_ presenter: MainPresenter, didFailFetchingHitsWith error: Error?)
}
