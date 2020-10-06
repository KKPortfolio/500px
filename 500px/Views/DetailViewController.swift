//
//  DetailViewController.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hidingView: UIVisualEffectView!
    @IBOutlet weak var textView: UITextView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailPhoto()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DetailViewController {
    func setupDetailPhoto() {
        var info = ""
        info += "Name: " + (self.photo?.name ?? "") + "\n"
        if let userName = self.photo?.attributes[PhotoFields.user] as? [String:Any] {
            info += "User Name: " + (userName[UserFields.fullname] as? String ?? (userName[UserFields.username] as? String) ?? "") + "\n"
        }
        info += "Description: " + (self.photo?.description ?? "") + "\n"
        self.textView.text = info
    }
}
