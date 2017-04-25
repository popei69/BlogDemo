//
//  PostController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol PostControllerDelegate {
    func reloadData(posts: [Post])
}

final class PostController: RequestDelegate {
    
    let delegate : PostControllerDelegate?
    
    init(delegate : PostControllerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchPosts() {
        
        PostService().loadPosts(completion: self.networkResult())
    }
    
    func networkResult() -> ((Result<Data, ErrorResult>) -> Void) {
        return { dataResult in 
            
            DispatchQueue.global(qos: .background).async(execute: { 
                switch dataResult {
                case .success(let data) : 
                    print("Network success \(data)")
                    ParserHelper.parse(data: data, completion: self.parserResult())
                    break
                case .failure(let error) :
                    print("Network error \(error)")
                    break
                }
            })
        }
    }
    
    func parserResult() -> ((Result<[Post], ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let posts) :
                    // reload data
                    print("Parser success \(posts)")
                    self.delegate?.reloadData(posts: posts)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
            }
            
        }
    }

}
