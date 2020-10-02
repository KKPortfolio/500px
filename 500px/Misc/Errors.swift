//
//  Errors.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import Foundation

public enum QueryPhotoError:Error {
    case failToParseJsonObject, photoNotFound, photoSizesCannotBeEmpty
}

public enum ImageObjectError:Error {
    case noUrlFound, noFormatFound, noSizeFound
}

public enum PhotoError:Error {
    case imageNotFound
}
