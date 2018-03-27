//
//  SpritzSwiftTests.swift
//  SpritzSwiftTests
//
//  Created by vincent Choubard on 26/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import XCTest
@testable import SpritzSwift

class SSTimerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsNotValid() {
        let timer = Timer()
        let ssTimer = SSTimer(timer: timer)
        XCTAssertEqual(timer.isValid, ssTimer.isValid)
    }
}
