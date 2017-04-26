//
//  RequestHandler.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

class RequestHandler {
    
    func networkResult<T: Parceable>(parser: @escaping ((Result<[T], ErrorResult>) -> Void)) -> 
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in 
                
                DispatchQueue.global(qos: .background).async(execute: { 
                    switch dataResult {
                    case .success(let data) : 
                        print("Network success \(data)")
                        ParserHelper.parse(data: data, completion: parser)
                        break
                    case .failure(let error) :
                        print("Network error \(error)")
                        break
                    }
                })
                
            }
    }
}
