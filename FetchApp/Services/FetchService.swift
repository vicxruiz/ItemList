//
//  FetchService.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/15/20.
//

import Foundation

class FetchService {
	enum HTTPError: Error {
		case non200StatusCode
		case noData
	}

	func fetchData(with request: URLRequest, requestID: String? = nil, completion: @escaping (String?, Data?, Error?) -> Void) {
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				print(error)
				completion(requestID, nil, error)
				return
			} else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
				print("non 200 http response: \(response.statusCode)")
				let myError = HTTPError.non200StatusCode
				completion(requestID, nil, myError)
				return
			}
			
			guard let data = data else {
				completion(requestID, nil, HTTPError.noData)
				return
			}
			completion(requestID, data, nil)
			}.resume()
	}
}
