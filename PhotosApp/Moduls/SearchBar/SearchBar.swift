//
//  SearchBar.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class SearchBar: UIView, UISearchBarDelegate {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchBarDelegate?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Constants.searchBarNibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func commonInit(){
        self.containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.backgroundColor = .clear
        containerView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        addSubview(containerView)
        searchBar.delegate = self
    }
    
    
    func performSearch(withText text: String?){
        endEditing(true)
        self.delegate?.searchBar(self, didEndEditingWithText: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.performSearch(withText: searchBar.text)
    }
    
    
    
}
