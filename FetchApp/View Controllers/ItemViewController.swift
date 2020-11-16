//
//  ItemTableViewController.swift
//  FetchApp
//
//  Created by Victor Ruiz on 11/15/20.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
	
	//MARK: - Properties
	
	let tableView = UITableView()
	let itemController = ItemController(fetchService: FetchService())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
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
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: TextContent.ItemTableView.cellIdentifier)
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
			])
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TextContent.ItemTableView.cellIdentifier, for: indexPath)
		return cell
	}
}
