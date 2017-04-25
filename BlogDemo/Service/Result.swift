//
//  Result.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
