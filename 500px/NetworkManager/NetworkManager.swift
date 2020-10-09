//
//  NetworkManager.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let url = "https://api.500px.com/v1/photos?feature="
    
    class func getPhotos(consumerKey: String,
                         page: Int,
                         rpp: Int=12,
                         photoSizes: [Int],
                         callback: @escaping ([Photo]?, Error?)->()) {
        guard !photoSizes.isEmpty else {
            callback(nil, QueryPhotoError.photoSizesCannotBeEmpty)
            return
        }
        
        let headers = ["consumer_key": consumerKey,
                       "term": "popular",
                       "page": String(page),
                       "rpp": String(rpp),
                       "image_size[]": photoSizes.map{"\($0)"}.joined(separator: ",")
        ]
//        Alamofire Request
        AF.request(url,
                   method: .get,
                   parameters: headers,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate()
            .responseJSON { (results) in
                if let dictionary = results.value as? [String:Any] {
                    do {
                        guard let photos = try Photo.parsePhotos(dictionary: dictionary) else {
                            return callback(nil, QueryPhotoError.photoNotFound)
                        }
                        callback(photos,nil)
                    } catch {
                        callback(nil, error)
                    }
                } else if results.error != nil {
                    return callback(nil, results.error)
                } else {
                    return callback(nil, QueryPhotoError.failToParseJsonObject)
                }
            }
    }
}
