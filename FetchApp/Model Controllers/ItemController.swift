//
//  ItemController.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/15/20.
//

import Foundation

class ItemController {
	
	//MARK: - Properties

	let fetchService: FetchService
	let baseURL = URL.baseURL
	var items: [Item] = []
	
	init(fetchService: FetchService) {
		self.fetchService = fetchService
	}
	
	enum Endpoints: String {
		case hiring = "hiring"
	}
}

//MARK: - Fetch Helper

extension ItemController {
	func fetchItems(completion: @escaping (Error?) -> Void) {
		let url = baseURL.appendingPathComponent(Endpoints.hiring.rawValue).appendingPathExtension(TextContent.Networking.json)
		
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.get.rawValue
		
		fetchService.fetchData(with: request) { (_, data, error) in
			if let error = error {
				completion(error)
			}
			guard let data = data else { return }
			
			let decoder = JSONDecoder()
			do {
				let data = try decoder.decode([Item].self, from: data)
				self.items = data
				completion(nil)
			} catch {
				print("error decoding data: \(error)")
				completion(error)
			}
		}
	}
}
