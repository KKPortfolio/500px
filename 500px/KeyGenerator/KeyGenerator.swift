//
//  KeyGenerator.swift
//  500px
//
//  Created by Kurt Kim on 2020-09-30.
//

import Foundation
import RNCryptor

//  Reads crypted key (cannot be read by human) from bundle then decrypts it back into consumer key
class KeyGenerator {

//    Make it singleton
    static let shared = KeyGenerator()
    
//    variables
    var encryptedKey: Data?
    var originalKey: Data?
    
//    functions
    func readFile(){
        let path = Bundle.main.path(forResource: "cryptedKey", ofType: "txt")
        do {
            self.encryptedKey = try Data(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print(error)
        }
    }
    
    func decryptKey(){
        do {
            self.originalKey = try RNCryptor.decrypt(data: self.encryptedKey!, withPassword: "500px")
        } catch {
            print(error)
        }
    }
}
