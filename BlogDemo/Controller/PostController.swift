//
//  PostController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol PostControllerDelegate {
    func reloadPosts(posts: [Post])
    func failFetchPost(error: ErrorResult)
}

final class PostController: RequestHandler {
    
    let postEndpoint = "https://jsonplaceholder.typicode.com/posts"
    
    let delegate : PostControllerDelegate?
    
    init(delegate : PostControllerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchPosts() {
        RequestService().loadData(urlString: postEndpoint, completion: self.networkResult(completion: self.parser))
    }
    
    var parser : ((Result<[Post], ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let posts) :
                    // reload data
                    print("Parser success \(posts)")
                    self.delegate?.reloadPosts(posts: posts)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self.delegate?.failFetchPost(error: error)
                    break
                }
            }
            
        }
    }

}
