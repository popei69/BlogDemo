//
//  Comment.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Comment {
    let id : Int
    let postId : Int
    let name : String
    let body : String
}

extension Comment : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Comment, ErrorResult> {
        if let id = dictionary["id"] as? Int,
            let postId = dictionary["postId"] as? Int,
            let name = dictionary["name"] as? String,
            let body = dictionary["body"] as? String {
            
            let newComment = Comment(id: id, postId: postId, name: name, body: body)
            
            return Result.success(newComment) 
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
