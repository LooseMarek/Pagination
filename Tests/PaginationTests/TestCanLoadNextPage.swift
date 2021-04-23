//
//  TestCanLoadNextPage.swift
//  Pagination
//
//  Created by Marek Loose on 24/02/2021.
//  Copyright © 2021 Backbase. All rights reserved.
//

import XCTest

@testable import Pagination

extension Pagination_Test {
    
    func testCanLoadNextPage_WhenLoadNextPageWasntCalledFirst_ShouldThrowFirstPageNotLoadedError() {
        // Given
        let index: Int = 2
        let listCount: Int = 3
        
        // When / Then
        XCTAssertThrowsError(try pagination.canLoadNextPage(at: index, listCount: listCount)) { error in
            XCTAssertEqual(error as! PaginationError, PaginationError.firstPageNotLoaded)
        }
    }
    
    func testCanLoadNextPage_WhenSetTotalPagesWasntCalledFirst_ShouldThrowTotalPagesNotSetError() {
        // Given
        let index: Int = 2
        let listCount: Int = 3
        
        pagination.loadNextPage()

        // When / Then
        XCTAssertThrowsError(try pagination.canLoadNextPage(at: index, listCount: listCount)) { error in
            XCTAssertEqual(error as! PaginationError, PaginationError.totalPagesNotSet)
        }
    }
    
    func testCanLoadNextPage_WhenDidntFinishFetching_ShouldReturnFalse() {
        // Given
        let index: Int = 2
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.loadNextPage()
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertFalse(result)
    }
    
    func testCanLoadNextPage_WhenThereAreNoMorePagesToLoad_ShouldReturnFalse() {
        // Given
        let index: Int = 2
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)
        pagination.loadNextPage() // Will load 2nd page
        pagination.finishedLoadingNextPage() // Finished loading 2st page
        pagination.loadNextPage() // Will load 3rd page
        pagination.finishedLoadingNextPage() // Finished loading 3st page

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertFalse(result)
    }
    
    func testCanLoadNextPage_WhenDidntScrollListToTriggerIndex_ShouldReturnFalse() {
        // Given
        let index: Int = 2
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.setPercentageScrollToLoadNextPage(0.5) // TriggerIndex at 50% - list item index should be 5 or above
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertFalse(result)
    }
    
    func testCanLoadNextPage_WhenDidScrollListToTriggerIndex_ShouldReturnTrue() {
        // Given
        let index: Int = 5
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.setPercentageScrollToLoadNextPage(0.5) // TriggerIndex at 50% - list item index should be 5 or above
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertTrue(result)
    }
    
    func testCanLoadNextPage_WhenDidScrollListToAboveTriggerIndex_ShouldReturnTrue() {
        // Given
        let index: Int = 10
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.setPercentageScrollToLoadNextPage(0.5) // TriggerIndex at 50% - list item index should be 5 or above
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertTrue(result)
    }
    
    func testCanLoadNextPage_WhenPercentageScrollToLoadNextPageIsMinAllowed_ShouldReturnTrue() {
        // Given
        let index: Int = 3
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.setPercentageScrollToLoadNextPage(0.3) // TriggerIndex at 30% - list item index should be 3 or above
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertTrue(result)
    }
    
    func testCanLoadNextPage_WhenPercentageScrollToLoadNextPageIsMaxAllowed_ShouldReturnTrue() {
        // Given
        let index: Int = 10
        let listCount: Int = 10
        let totalPages: Int = 3
        
        pagination.setPercentageScrollToLoadNextPage(1.0) // TriggerIndex at 30% - list item index should be 3 or above
        
        pagination.loadNextPage() // Will load 1st page
        pagination.finishedLoadingNextPage() // Finished loading 1st page
        pagination.setTotalPages(totalPages)

        // When / Then
        let result: Bool = try! pagination.canLoadNextPage(at: index, listCount: listCount)
        
        XCTAssertTrue(result)
    }
}
