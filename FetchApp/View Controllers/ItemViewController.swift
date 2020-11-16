//
//  ItemTableViewController.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/15/20.
//

import Foundation
import UIKit
import os.log

class ItemViewController: UIViewController {
	
	//MARK: - Properties
	
	let tableView = UITableView()
	let itemController = ItemController(fetchService: FetchService())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		fetchItems()
	}
}

//MARK: - Setup Views

extension ItemViewController {
	private func setupViews() {
		setupTableView()
		setupNavBar()
	}
	
	private func setupNavBar() {
		self.title = TextContent.NavBar.title
	}
}

//MARK: Table View

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
	
	private func setupTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: TextContent.ItemTableView.cellIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
			])
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemController.sections[section].count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return itemController.sections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if itemController.sortedListStringIds.isEmpty {
			return nil
		} else {
			return itemController.sortedListStringIds[section]
		}
	}
	
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		print(itemController.sortedListStringIds)
		return itemController.sortedListStringIds
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TextContent.ItemTableView.cellIdentifier, for: indexPath)
		let item = itemController.sections[indexPath.section][indexPath.row]
		if let name = item.name {
			cell.textLabel?.text = name
		}
		cell.detailTextLabel?.text = "ID: \(item.id)"
		return cell
	}
}

//MARK: - Fetch data

extension ItemViewController {
	func fetchItems() {
		itemController.fetchItems { (error) in
			DispatchQueue.main.async {
				if error != nil {
					os_log(.error, "Unable to fetch items")
				} else {
					self.tableView.reloadData()
				}
			}
		}
	}
}
