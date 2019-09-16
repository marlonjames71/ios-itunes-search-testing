//
//  MockDataLoader.swift
//  iTunes SearchTests
//
//  Created by Marlon Raskin on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
@testable import iTunes_Search

class MockDataLoader: NetworkDataLoader {
	var request: URLRequest?
	var data: Data?
	var error: Error?

	func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {

		self.request = request // Spy on the request that's passed in

		// we inject the data or the error into the completion call
		DispatchQueue.main.async {
			completion(self.data, self.error)
		}
	}
}
