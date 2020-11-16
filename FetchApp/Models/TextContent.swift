//
//  TextContent.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/15/20.
//

import Foundation

struct TextContent {
	
	static let baseURL = "https://fetch-hiring.s3.amazonaws.com"
	
	struct NavBar {
		static let title = "Item List"
	}
	
	struct ItemTableView {
		static let cellIdentifier = "ItemCell"
	}
	
	struct Networking {
		static let json = "json"
	}
}
