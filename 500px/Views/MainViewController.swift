//
//  MainViewController.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    var viewModel = ViewModel()
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.photos = [Photo]()
        viewModel.getConsumerKey()
        self.getPhotos(resetPhotos: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateCollectionViewLayout()
    }
}

extension MainViewController {
    func getPhotos(resetPhotos: Bool, completion: (()->())?) {
        NetworkManager.getPhotos(consumerKey: self.viewModel.consumerKey,
                                 page: self.viewModel.page,
                                 rpp: self.viewModel.rpp,
                                 photoSizes: self.viewModel.photoSizes) { (retrievedPhotos, error) in
            if retrievedPhotos != nil {
                self.viewModel.page += 1
                resetPhotos ? self.viewModel.photos = retrievedPhotos : self.viewModel.photos.append(contentsOf: retrievedPhotos!)
                self.mainCollectionView.layoutIfNeeded()
                self.mainCollectionView.reloadData()
            } else {
                print("Could not retrieve photos!")
            }
            completion?()
        }
    }
}

extension MainViewController: MainLayoutDelegate {
    func collectionView(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return viewModel.photos[indexPath.item].getPhotoSize()
    }
    func setupCollectionView(){
        if let layout = mainCollectionView.collectionViewLayout as? MainLayout {
            layout.delegate = self
        }
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    func updateCollectionViewLayout() {
        self.mainCollectionView.collectionViewLayout.invalidateLayout()
        if self.viewModel.lastIndexPath != nil {
            DispatchQueue.main.async {
                self.mainCollectionView.scrollToItem(at: self.viewModel.lastIndexPath!, at: .bottom, animated: false)
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewModel.lastIndexPath = self.mainCollectionView.indexPathsForVisibleItems.last
        // load next page when scrollView reaches the end
        guard self.viewModel.isLoading == false else { return }
        var offset:CGFloat = 0
        var sizeLength:CGFloat = 0
        offset = scrollView.contentOffset.y
        sizeLength = scrollView.contentSize.height - scrollView.frame.size.height
        if offset >= sizeLength {
            self.viewModel.isLoading = true
            self.getPhotos(resetPhotos: false, completion: {
                self.viewModel.isLoading = false
            })
        }
    }
//    when cell is selected, it goes to the detailView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectedRow = indexPath.row
        performSegue(withIdentifier: "toPhotoDetail", sender: self)
    }
//    sends photo data of the selected cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let destinationViewController = segue.destination as! DetailViewController
            if self.viewModel.photos != nil && self.viewModel.selectedRow != nil && self.viewModel.selectedRow! < self.viewModel.photos!.count {
                destinationViewController.photo = self.viewModel.photos![self.viewModel.selectedRow!]
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        cell.imageView.contentMode = .scaleAspectFill
        cell.photo = self.viewModel.photos?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
