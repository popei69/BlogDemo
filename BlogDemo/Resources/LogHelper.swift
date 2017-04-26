//
//  DebugHelper.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
    #endif
}
