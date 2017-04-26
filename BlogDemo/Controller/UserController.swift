//
//  UserController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol UserControllerDelegate {
    func reloadData(users: [User])
}
