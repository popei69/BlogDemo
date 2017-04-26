//
//  RequestFactoryTest.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import XCTest

class RequestFactoryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMethod() {
        
        let request = RequestFactory.request(method: .POST, url: URL(string: "https://www.google.com")!)
        
        XCTAssertEqual("POST", request.httpMethod!)
    }
    
}
