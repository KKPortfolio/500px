//
//  DetailViewController.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hidingView: UIVisualEffectView!
    @IBOutlet weak var textView: UITextView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupScrollView()
        setupTapGestures()
        let url = URL(string: photo?.images[photo.images.count - 1].url ?? "")
        imageView.kf.setImage(with: url)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DetailViewController {
    func setupTextView() {
        var info = ""
        info += "Name: " + (self.photo?.name ?? "") + "\n"
        if let userName = self.photo?.attributes[PhotoFields.user] as? [String:Any] {
            info += "User Name: " + (userName[UserFields.fullname] as? String ?? (userName[UserFields.username] as? String) ?? "") + "\n"
        }
        info += "Description: " + (self.photo?.description ?? "") + "\n"
        self.textView.text = info
        self.textView.isEditable = false
        self.textView.isUserInteractionEnabled = false
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func setupScrollView() {
        self.imageView.isUserInteractionEnabled = true
        self.imageView.contentMode = .scaleAspectFit
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
//        self.scrollView.contentSize = self.imageView.frame.size
        self.scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func setupTapGestures(){
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(detail))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(zoom))
        singleTapGesture.numberOfTapsRequired = 1
        doubleTapGesture.numberOfTapsRequired = 2
        singleTapGesture.delegate = self
        doubleTapGesture.delegate = self
        self.imageView.addGestureRecognizer(singleTapGesture)
        self.imageView.addGestureRecognizer(doubleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func detail(gesture: UITapGestureRecognizer) {
        self.hidingView.isHidden = !self.hidingView.isHidden
    }
    
    @objc func zoom(gesture: UITapGestureRecognizer) {
        if self.scrollView.zoomScale > 1.0 {
            self.scrollView.setZoomScale(1.0, animated: true)
        } else {
            self.scrollView.setZoomScale(4.0, animated: true)
        }
    }
}
