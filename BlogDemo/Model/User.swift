//
//  User.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct User {
    let id : Int
    let name : String
    let email : String
    let phone : String
}

extension User : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<User, ErrorResult> {
        
        if let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let phone = dictionary["phone"] as? String {
            
            let newUser = User(id: id, name: name, email: email, phone: phone)
            
            return Result.success(newUser) 
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
