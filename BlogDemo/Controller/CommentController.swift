//
//  BlogDemo.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol CommentControllerDelegate {
    func reloadComments(comments: [Comment])
}

final class CommentController : RequestHandler {
    
    let commentEndpoint = "https://jsonplaceholder.typicode.com/comments"
    
    var delegate : CommentControllerDelegate?
    
    init(delegate : CommentControllerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchComments() {
        RequestService().loadData(urlString: commentEndpoint, completion: networkResult(completion: self.parser))
    }
    
    var parser : ((Result<[Comment], ErrorResult>) -> Void) {
        return { commentsResult in 
            
            DispatchQueue.main.async {
                switch commentsResult {
                case .success(let comments) :
                    // reload data
                    print("Parser success \(comments)")
                    self.delegate?.reloadComments(comments: comments)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
            }
            
        }
    } 
}

extension CommentController {
    
    // add helper to get comments by post id
    static func commentsByPostId(comments: [Comment], postId: Int) -> [Comment] {
        return comments.filter({$0.postId == postId})
    }
}
