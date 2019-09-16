//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Spencer Curtis on 8/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

enum SearchError: Error { //, Equatable {
	case noData
	case urlSessionError // (Error)
	case decodeError // (Error)
}

class SearchResultController {
	// https://itunes.apple.com/search?entity=software&term=garageband
	let baseURL = URL(string: "https://itunes.apple.com/search")!
	var searchResults: [SearchResult] = []
	let dataLoader: NetworkDataLoader

	init(dataLoader: NetworkDataLoader = URLSession.shared) { // <- initializer dependency injection
		self.dataLoader = dataLoader
	}


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

    
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping (Result<[SearchResult], SearchError>) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let parameters = ["term": searchTerm,
                          "entity": resultType.rawValue]
        let queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue


        
		dataLoader.loadData(with: request) { (data, error) in
            
            if let error = error {
				NSLog("Error fetching data: \(error)")
				completion(.failure(.urlSessionError)) //(error))) // TODO: Test!
				return
			}

            guard let data = data else {
				completion(.failure(.noData)) // TODO: Test!
				return
			}
            
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = result.results
				completion(.success(self.searchResults))
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
				completion(.failure(.decodeError)) //(error)))
            }
        }
    }
}
