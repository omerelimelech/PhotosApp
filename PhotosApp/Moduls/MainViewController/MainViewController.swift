//
//  ViewController.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: BaseViewController{
   
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MainPresenter?
    
    var dataSource: PhotoCollectionViewDataSource?
    
    @IBOutlet weak var searchBar: SearchBar!
    
    var currentKeyword: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        self.dataSource = PhotoCollectionViewDataSource(withHits: nil, reuseId: MainCollectionViewCell.reuseId, cellType: .preview)
        collectionView.dataSource = dataSource
        searchBar.delegate = self
        collectionView.register(UINib(nibName: MainCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.fotterReusableId)
        self.presenter = MainPresenter(withDelegate: self)
        
    }
    
    @IBAction func searchTapped(_ sender: UIBarButtonItem) {
        self.searchBar.performSearch(withText: self.searchBar.searchBar.text)
    }
    
}

// MARK: CollectionViewDelegate & DelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfImagesInRow: CGFloat = 5.2
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        let edgeInset = collectionView.contentInset.right
        let height = collectionView.frame.height
        
        // calculation of collectionView height - spaces devided by number of items wanted from top to bottom.
        let cellHeight = (height - (spacing! * CGFloat(Int(numberOfImagesInRow))) - (edgeInset * 4) ) / numberOfImagesInRow
        return CGSize(width: cellHeight, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = self.dataSource else {return}
        self.navigate(.bigPhotoPage(dataSource, indexPath: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let dataSource = self.dataSource, let hits = dataSource.hits, let keyword = self.currentKeyword else {return}
        let numberOfHitsInPage = 20
        if indexPath.item == hits.count - 2 {
            self.presenter?.getByKeyword(keyword: keyword, page: (hits.count / numberOfHitsInPage) + 1)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        // do not show loading indicator if we don't have hits yet.
        let height : CGFloat = self.dataSource?.hits?.count ?? 0 > 0 ? 50 : 0
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
}


// MARK: Main Delegate
extension MainViewController: MainDelegate{
    func mainPresenter(_ presenter: MainPresenter, didChangeFetchingState state: FetchingState) {
        switch state {
        case .ended:
            SVProgressHUD.dismiss()
        default:
            return
        }
    }
    
    func mainPresenter(_ presenter: MainPresenter, didFetchHits hits: [Hit]?) {
        guard hits?.count ?? 0 > 0 else { alert(body: Constants.noResults); return }
        self.dataSource?.hits = hits
        self.collectionView.reloadData()
    }
    
    func mainPresenter(_ presenter: MainPresenter, didFetchHits hits: [Hit]?, forPage page: Int) {
        guard let hits = hits else {return}
        self.dataSource?.hits?.append(contentsOf: hits)
        self.collectionView.reloadData()
    }
    
    func mainPresenter(_ presenter: MainPresenter, didFailFetchingHitsWith error: Error?) {
        guard let error = error else {return}
        self.alert(body: error.localizedDescription)
    }
}

// MARK: SearchBar Delegate
extension MainViewController : SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, didEndEditingWithText text: String?) {
        guard let text = text else {return}
        self.currentKeyword = text
        SVProgressHUD.show()
        self.presenter?.getByKeyword(keyword: text, page: 1)
    }
}
