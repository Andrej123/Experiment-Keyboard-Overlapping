//
//  ViewController.swift
//  Keyboard Overlapping Fix
//
//  Created by Andrej Krizmancic on 29/06/2018.
//  Copyright © 2018 Andrej Krizmancic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var xButton: UIButton!
	@IBOutlet fileprivate var sendButton: UIButton!
	@IBOutlet fileprivate var tableView: UITableView!
	@IBOutlet fileprivate var textField: UITextField!


	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction fileprivate func xButtonTapped() {
		print("\(#function)")
	}

	@IBAction fileprivate func sendButtonTapped() {
		print("\(#function)")
	}


}


extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 18
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .yellow
		cell.textLabel?.text = "Row \(indexPath.row)"
		return cell
	}

}


extension ViewController: UITableViewDelegate {

}


extension ViewController: UITextFieldDelegate {

}
