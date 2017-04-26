//
//  Post.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Post {
    let id : Int
    let userId : Int
    let title : String
    let body : String
}

extension Post : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Post, ErrorResult> {
        
        if let id = dictionary["id"] as? Int,
            let userId = dictionary["userId"] as? Int,
            let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String {
            
            let newPost = Post(id: id, userId: userId, title: title, body: body)
            
            return Result.success(newPost) 
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
