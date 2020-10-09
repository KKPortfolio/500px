//
//  ViewModel.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import Foundation
import UIKit

class ViewModel {
    var consumerKey = ""
    var photos: [Photo]!
    var numberOfItemsInRow = 3
    var lastIndexPath: IndexPath?
    var page = 1
    var rpp = 30
    var thumbnailSize: [CGSize]!
    var photoSizes = [3,4]
    var isLoading = false
    var selectedRow: Int?
    var didGetPhoto: Bool?
    
//    to load consumer key from crypted key
    func getConsumerKey(){
        KeyGenerator.shared.readFile()
        KeyGenerator.shared.decryptKey()
        self.consumerKey = String(decoding: KeyGenerator.shared.originalKey!, as: UTF8.self)
    }
}
