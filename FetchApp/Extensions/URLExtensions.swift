//
//  URLExtensions.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/16/20.
//

import Foundation

extension URL {
	static var baseURL: URL {
		return URL(string: TextContent.baseURL)!
	}
}
