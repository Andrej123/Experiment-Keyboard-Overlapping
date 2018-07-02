//
//  ViewController.swift
//  Keyboard Overlapping Fix
//
//  Created by Andrej Krizmancic on 29/06/2018.
//  Copyright © 2018 Andrej Krizmancic. All rights reserved.
//

// Links:
// https://stackoverflow.com/questions/28813339/move-a-view-up-only-when-the-keyboard-covers-an-input-field
// https://github.com/slackhq/SlackTextViewController/issues/630
// https://www.appcoda.com/custom-content-view/


import UIKit

// add move to bottom of table view


// MARK: - ViewController
class ViewController: UIViewController {

	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var xButton: UIButton!
	@IBOutlet fileprivate var sendButton: UIButton!
	@IBOutlet fileprivate var tableView: UITableView!
	@IBOutlet fileprivate var textField: UITextField!
	@IBOutlet fileprivate var keyboardFrameMatchingView: UIView!
	@IBOutlet fileprivate var keyboardFrameMatchingViewHeightConstraint: NSLayoutConstraint!

	var keyboardAvoider: KeyboardAvoider?

	override func viewDidLoad() {
		super.viewDidLoad()
		keyboardAvoider = KeyboardAvoider(keyboardFrameMatchingViewHeightConstraint: keyboardFrameMatchingViewHeightConstraint, superview: view, animationCompletion: { [weak self] in self?.scrollToBottom() })
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		scrollToBottom()
	}

	fileprivate func scrollToBottom() {
		let numberOfRows = tableView.numberOfRows(inSection: 0) - 1
		let indexPath = IndexPath(item: numberOfRows, section: 0)
		tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
	}


	@IBAction fileprivate func xButtonTapped() {
		textField.resignFirstResponder()
	}

	@IBAction fileprivate func sendButtonTapped() {
		textField.resignFirstResponder()
	}

}


// MARK: - UITableViewDataSource
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



// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		textField.resignFirstResponder()
	}

}



// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}


