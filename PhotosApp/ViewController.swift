//
//  ViewController.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getByQuery { (result) in
            switch result{
            case .success(let value):
                print (value)
            case .failure(let error):
                print (error)
            }
        }
    }


}

