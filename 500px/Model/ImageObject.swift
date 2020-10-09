//
//  ImageObject.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit

public class ImageObject {
    var url:String
    var format: String
    var size: Int
    
    init(imageDictionary dic: [String:Any]) throws {
        guard let url = dic[ImagesFields.url] as? String else { throw ImageObjectError.noUrlFound }
        guard let format = dic[ImagesFields.format] as? String else { throw ImageObjectError.noFormatFound }
        guard let size = dic[ImagesFields.size] as? Int else { throw ImageObjectError.noSizeFound }
        self.url = url
        self.format = format
        self.size = size
    }
}
