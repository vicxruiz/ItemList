//
//  ItemTableViewCell.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/16/20.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .value1, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
