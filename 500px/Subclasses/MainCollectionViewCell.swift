//
//  MainCollectionViewCell.swift
//  500px
//
//  Created by Kurt Kim on 2020-10-05.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
//    set image with Kingfisher
    var photo: Photo? {
        didSet {
            if photo != nil {
                let url = URL(string: photo!.images[0].url)
                imageView.kf.setImage(with: url)
            }
        }
    }
}
