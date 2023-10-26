//
//  Pagination.swift
//  Athdak
//
//  Created by Ahmed Fathy on 06/09/2023.
//

import Foundation
// MARK: - Pagination
public struct Pagination: Codable {
    public var totalItems, countItems, perPage, totalPages: Int?
    public var currentPage: Int?
    public var nextPageURL, pervPageURL: String?

    public init(
        totalItems: Int? = nil,
        countItems: Int? = nil,
        perPage: Int? = nil,
        totalPages: Int? = nil,
        currentPage: Int? = nil,
        nextPageURL: String? = nil,
        pervPageURL: String? = nil
    ) {
        self.totalItems = totalItems
        self.countItems = countItems
        self.perPage = perPage
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.nextPageURL = nextPageURL
        self.pervPageURL = pervPageURL
    }
    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items"
        case countItems = "count_items"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPageURL = "next_page_url"
        case pervPageURL = "perv_page_url"
    }
    
    public func pageRequest(isReset: Bool = false) -> Int? {
        if isReset == true { return 1 }
        guard let currentPage, let totalPages else { return 1 }
        if totalPages > currentPage { return currentPage + 1 }
        if totalPages == currentPage { return nil }
        return nil
    }
    
    public func isLast() -> Bool {
        currentPage == totalPages
    }
}
