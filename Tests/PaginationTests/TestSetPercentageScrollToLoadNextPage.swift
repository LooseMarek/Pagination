//
//  TestSetPercentageScrollToLoadNextPage.swift
//  Pagination
//
//  Created by Marek Loose on 24/02/2021.
//  Copyright © 2021 Backbase. All rights reserved.
//

import XCTest

@testable import Pagination

extension Pagination_Test {
    
    func testSetPercentageScrollToLoadNextPage_WhenSettingValueBellowAllowed_ShouldSetMinAllowedValue() {
        // Given
        let percentageScroll: Double = 0.1
        
        // When
        pagination.setPercentageScrollToLoadNextPage(percentageScroll)
        
        // Then
        XCTAssertEqual(pagination.percentageScrollToLoadNextPage, 0.3)
    }
    
    func testSetPercentageScrollToLoadNextPage_WhenSettingValueAboveAllowed_ShouldSetMaxAllowedValue() {
        // Given
        let percentageScroll: Double = 2.0
        
        // When
        pagination.setPercentageScrollToLoadNextPage(percentageScroll)
        
        // Then
        XCTAssertEqual(pagination.percentageScrollToLoadNextPage, 1.0)
    }
    
    func testSetPercentageScrollToLoadNextPage_WhenSettingAllowedValue_ShouldSetValue() {
        // Given
        let percentageScroll: Double = 0.5
        
        // When
        pagination.setPercentageScrollToLoadNextPage(percentageScroll)
        
        // Then
        XCTAssertEqual(pagination.percentageScrollToLoadNextPage, percentageScroll)
    }
}
