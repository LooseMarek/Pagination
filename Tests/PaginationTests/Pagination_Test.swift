//
//  Pagination_Test.swift
//  Pagination
//
//  Created by Marek Loose on 24/02/2021.
//  Copyright © 2021 Backbase. All rights reserved.
//

import XCTest

@testable import Pagination

class Pagination_Test: XCTestCase {
    
    var pagination: Pagination!

    override func setUp() {
        super.setUp()
        pagination = Pagination()
    }

    override func tearDown() {
        pagination = nil
        super.tearDown()
    }
}
