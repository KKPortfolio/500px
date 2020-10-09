//
//  Constants.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import Foundation

//  Constants used for parsing JSON
public struct QueryFields {
    static let photos = "photos"
}

public struct PhotoFields {
    static let description = "description"
    static let height = "height"
    static let id = "id"
    static let imageFormat = "image_format"
    static let images = "images"
    static let imageUrl = "image_url"
    static let name = "name"
    static let url = "url"
    static let user = "user"
    static let width = "width"
}

public struct ImagesFields {
    static let format = "format"
    static let httpsUrl = "https_url"
    static let size = "size"
    static let url = "url"
}

public struct UserFields {
    static let city = "city"
    static let country = "country"
    static let firstname = "firstname"
    static let fullname = "fullname"
    static let id = "id"
    static let lastname = "lastname"
    static let username = "username"
}
