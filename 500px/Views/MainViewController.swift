//
//  MainViewController.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    //    Variables
    var viewModel = ViewModel()
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.photos = [Photo]()
        viewModel.getConsumerKey()
        viewModel.getPhotos(resetPhotos: true, completion: nil)
        if (viewModel.didGetPhoto!) {
            self.mainCollectionView.layoutIfNeeded()
            self.mainCollectionView.reloadData()
        }
    }
}

extension MainViewController {
    
    
}

extension MainViewController: MainLayoutDelegate {
    func collectionView(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return viewModel.photos[indexPath.item].getPhotoSize()
    }
    func setupCollectionView(){
        if let layout = mainCollectionView.collectionViewLayout as? MainLayout {
            layout.delegate = self
        }
    }
}
