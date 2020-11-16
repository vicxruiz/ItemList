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
	var items: [Item] = [] {
		didSet {
			filterUnnamedItems()
			generateSections()
		}
	}
	var filteredItems: [Item] = []
	var sections: [[Item]] = [[]]
	var sortedListStringIds: [String] = []
	
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

//MARK: - Update Item data

extension ItemController {
	private func filterUnnamedItems() {
		filteredItems = items.filter{ $0.name?.isEmpty == false }
	}
	
	private func generateSections() {
		let listIds = filteredItems.map { $0.listId }
		let uniqueListIds = Array(Set(listIds))
		let sortedListIds = uniqueListIds.sorted()
		sortedListStringIds = sortedListIds.map { String($0) }
		sections = sortedListIds.map{ listId in
			return filteredItems
				.filter { $0.listId == listId }
				.sorted { $0.name! < $1.name! }
		}
	}
}
