//
//  Pagination.swift
//  Modules
//
//  Created by Marek Loose on 24/02/2021.
//  Copyright © 2021 Backbase. All rights reserved.
//

public protocol PaginationProtocol {
    var page: Int? { get }
    
    func setTotalPages(_ totalPages: Int)
    func setPercentageScrollToLoadNextPage(_ percentageScroll: Double)
    
    func canLoadNextPage(at index: Int, listCount: Int) throws -> Bool
    func loadNextPage()
    func finishedLoadingNextPage()
}

public enum PaginationError: Error {
    case firstPageNotLoaded
    case totalPagesNotSet
}

public class Pagination: PaginationProtocol {
    
    private let minPercentageScrollToLoadNextPage: Double = 0.3
    private let maxPercentageScrollToLoadNextPage: Double = 1.0
    
    public var page: Int?
    private var totalPages: Int?
    /**
     List position to allow for loading the next page. Default set to 70%.
     */
    private(set) var percentageScrollToLoadNextPage: Double = 0.7
    private var isLoading = false
    
    // MARK: - Init
    
    public init() {}
    
    public func setTotalPages(_ totalPages: Int) {
        self.totalPages = totalPages
    }
    
    /**
     Set percentage scroll position to allow for fetching next page.
     Allowed values between 30% and 100%.
     Setting it bellow or above allowed percentage will set it to min and max allowed value respectively.
     */
    public func setPercentageScrollToLoadNextPage(_ percentageScroll: Double) {
        let isPercentageScrollBellowAllowed = percentageScroll < minPercentageScrollToLoadNextPage
        let isPercentageScrollAboveAllowed = percentageScroll > maxPercentageScrollToLoadNextPage
        percentageScrollToLoadNextPage = isPercentageScrollBellowAllowed ? minPercentageScrollToLoadNextPage : (isPercentageScrollAboveAllowed ? maxPercentageScrollToLoadNextPage : percentageScroll)
    }
    
    /**
     Check if pagination should load another page by checking scroll index relative to size of the list.
     It uses `percentageScrollToLoadNextPage` to set the trigger index threshold.
     
     Throws:
     - `firstPageNotLoaded`: when inital fetch wasn't performed
     - `totalPagesNotSet`: when totalPages wasn't set after initial fetch
     */
    public func canLoadNextPage(at index: Int, listCount: Int) throws -> Bool {
        guard let page else { throw PaginationError.firstPageNotLoaded }
        guard let totalPages else { throw PaginationError.totalPagesNotSet }
        
        if isLoading { return false }
        
        let isLastPage = page == totalPages
        
        if isLastPage { return false }
        
        let triggerIndex = Int(Double(listCount) * percentageScrollToLoadNextPage)
        let didScrollAboveTriggerIndex = index >= triggerIndex
        
        return didScrollAboveTriggerIndex
    }
    
    public func loadNextPage() {
        page = (page ?? 0) + 1
        isLoading = true
    }
    
    public func finishedLoadingNextPage() {
        isLoading = false
    }
}
