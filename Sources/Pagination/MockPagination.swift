//
//  MockPagination.swift
//  
//
//  Created by Marek Loose on 24/02/2021.
//

import Foundation

public class MockPagination: PaginationProtocol {
    
    public var setTotalPagesCallCount: Int = 0
    public var setPercentageScrollToLoadNextPageCallCount: Int = 0
    public var canLoadNextPageCallCount: Int = 0
    public var loadNextPageCallCount: Int = 0
    public var finishedLoadingNextPageCallCount: Int = 0

    public var setTotalPagesInput: Int?
    public var setPercentageScrollToLoadNextPageInput: Double?
    public var canLoadNextPageIndexInput: Int?
    public var canLoadNextPageListCountInput: Int?
    
    public var mockCanLoadNextPage: Bool = false
    
    public var page: Int = -1
    
    public init() {}
    
    public func setTotalPages(_ totalPages: Int) {
        setTotalPagesCallCount += 1
        
        setTotalPagesInput = totalPages
    }
    
    public func setPercentageScrollToLoadNextPage(_ percentageScroll: Double) {
        setPercentageScrollToLoadNextPageCallCount += 1
        
        setPercentageScrollToLoadNextPageInput = percentageScroll
    }
    
    public func canLoadNextPage(at index: Int, listCount: Int) throws -> Bool {
        canLoadNextPageCallCount += 1
        
        canLoadNextPageIndexInput = index
        canLoadNextPageListCountInput = listCount
        
        return mockCanLoadNextPage
    }
    
    public func loadNextPage() {
        loadNextPageCallCount += 1
    }
    
    public func finishedLoadingNextPage() {
        finishedLoadingNextPageCallCount += 1
    }
}
