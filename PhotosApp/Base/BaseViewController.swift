//
//  BaseViewController.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

typealias sbData = (storyboardName: String, storyboardId: String)
public class BaseViewController: UIViewController{
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func navigate(_ navigation: PhotosNaivgation) {
        Router.default.navigate(navigation, from: self)
    }
    
    
    func alert(withTitle title: String = "Alert", body: String, buttonTitle: String = "Ok"){
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    static func initialize<T: UIViewController>(data: sbData, type : T.Type) -> T{
        guard let vc = UIStoryboard(name: data.storyboardName, bundle: nil).instantiateViewController(withIdentifier: data.storyboardId) as? T else {return UIViewController() as! T}
        return vc
    }
}
