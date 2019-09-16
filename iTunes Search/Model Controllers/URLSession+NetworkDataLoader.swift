//
//  URLSession+NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Marlon Raskin on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {

	func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		let task = self.dataTask(with: request) { (data, _, error) in
			completion(data, error)
		}
		task.resume()
	}
}
