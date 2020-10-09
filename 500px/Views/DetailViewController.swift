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
        setupImageView()
        setupTextView()
        setupTextViewConstraint()
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
    
    func setupTextViewConstraint() {
        self.textView.layer.masksToBounds = true
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = self.textView.leadingAnchor.constraint(equalTo: self.hidingView.leadingAnchor)
        let trailingContraint = self.textView.trailingAnchor.constraint(equalTo: self.hidingView.trailingAnchor)
        let centerConstraint = self.textView.centerYAnchor.constraint(equalTo: self.hidingView.centerYAnchor)
        let heightConstraint = self.textView.heightAnchor.constraint(equalTo: self.hidingView.heightAnchor)
        let widthConstraint = self.textView.widthAnchor.constraint(equalTo: self.hidingView.widthAnchor)
        NSLayoutConstraint.activate([leadingConstraint,trailingContraint,centerConstraint,heightConstraint,widthConstraint])
        self.hidingView.layoutIfNeeded()
    }
    
    func setupImageView() {
        self.imageView.isUserInteractionEnabled = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.layer.masksToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = self.imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor)
        let trailingContraint = self.imageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        let centerConstraint = self.imageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let heightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        let widthConstraint = self.imageView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        NSLayoutConstraint.activate([leadingConstraint,trailingContraint,centerConstraint,heightConstraint,widthConstraint])
        self.scrollView.layoutIfNeeded()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func setupScrollView() {
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
//    single tap to hide/show textView
//    double tap to zoom in and out of the image
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
