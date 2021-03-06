//
//  UserController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol UserControllerDelegate {
    func reloadUsers(users: [User])
}

final class UserController : RequestHandler {
    
    let userEndpoint = "https://jsonplaceholder.typicode.com/users"
    
    let delegate : UserControllerDelegate?
    
    init(delegate: UserControllerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchUsers() {
        RequestService().loadData(urlString: userEndpoint, completion: self.networkResult(completion: self.parser))
    }
    
    var parser : ((Result<[User], ErrorResult>) -> Void) {
        return { usersResult in 
            
            DispatchQueue.main.async {
                switch usersResult {
                case .success(let users) :
                    // reload data
                    print("Parser success \(users)")
                    self.delegate?.reloadUsers(users: users)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
            }
            
        }
    }
}

extension UserController {

    // add helper to get user by id
    static func userById(users: [User], id: Int) -> User? {
        return users.first(where: {$0.id == id})
    }
}
