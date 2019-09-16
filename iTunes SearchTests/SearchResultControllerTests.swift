//
//  SearchResultControllerTests.swift
//  iTunes SearchTests
//
//  Created by Marlon Raskin on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import XCTest
@testable import iTunes_Search

/*
Dependencies:
- URL Session
- ResultType
- URL
- URLRequest
-searchTerm
- URLQueryItems

What are tests that we can create?
- Are we decoding the onject properly?
- Are we constructing the URL correctly?
- SearchResults Array is not empty after search
- empty? Nothing to return / something was
- Fails elegantly with bad data
- Is our completion handler is always called?
- Feature: provide
*/

class SearchResultsControllerTests: XCTestCase {


	func testSearchResultController() {

		let controller = SearchResultController()
		let didFinishSearching = self.expectation(description: "Finished searching for term")
		controller.performSearch(for: "Garage Band", resultType: .software) {
			didFinishSearching.fulfill()
			XCTAssertTrue(controller.searchResults.count > 0)
		}
		wait(for: [didFinishSearching], timeout: 5)
//		XCTFail()
	}

	func testSearchResultForGoodData() {
		// URLSession dependency is locking us into async / delayed logic

		
	}
}
