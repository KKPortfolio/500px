//
//  Photo.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import UIKit

class Photo {

    //    Variables
    var name: String?
    var description: String?
    var images: [ImageObject]
    var attributes: [String:Any]
    
    init(photo: [String:Any]) throws {
        
        images = [ImageObject]()
        attributes = [String:Any]()
        
        for(key, value) in photo {
            switch key {
            case PhotoFields.name:
                self.name = value as? String
            case PhotoFields.description:
                self.description = value as? String
            case PhotoFields.images:
                guard let imagesDictionary = value as? [[String:Any]] else { throw
                    PhotoError.imageNotFound
                }
                try self.parseImages(imagesDictionary: imagesDictionary)
            default:
                attributes.updateValue(value, forKey: key)
            }
        }
        if self.images.isEmpty {
            throw PhotoError.imageNotFound
        }
    }
    
    func getPhotoSize() -> CGSize {
        if let width = attributes[PhotoFields.width] as? Int {
            if let height = attributes[PhotoFields.height] as? Int {
                return CGSize(width: width, height: height)
            }
        }
//        if not given
        return CGSize(width: 180, height: 180)
    }
    
    func parseImages(imagesDictionary: [[String:Any]]) throws {
        for image in imagesDictionary {
            do {
                images.append(try ImageObject(imageDictionary: image))
            } catch {
                print("ImageObject creation failed", error.localizedDescription)
                continue
            }
        }
        if images.isEmpty { throw
            PhotoError.imageNotFound
        }
    }
    
    class func parsePhotos(dictionary: [String:Any]) throws -> [Photo]? {
        if let photos = dictionary[QueryFields.photos] as? [Any] {
            var results = [Photo]()
            for item in photos {
                if let photoDictionary = item as? [String:Any] {
                    do {
                        results.append(try Photo(photo: photoDictionary))
                    } catch {
                        print("Photo parsing failed", error)
                        continue
                    }
                } else {
                    print("No Dictionary")
                }
            }
            return results
        }
        return nil
    }
}
