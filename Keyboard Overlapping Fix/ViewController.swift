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


	override func viewDidLoad() {
		super.viewDidLoad()
		registerForKeyboardNotifications()
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


// MARK: - Behaviour to prevent keyboard overlapping
extension ViewController {
	func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
	}

	func deregisterFromKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}

	@objc func keyboardWillBeShown(notification: NSNotification) {
		guard let keyboardHeightValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
			let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
			let curveRaw = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
				return
		}
		let keyboardHeight = keyboardHeightValue.cgRectValue.height
		let animationOptions = UIViewAnimationOptions(rawValue: curveRaw)
		UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
			self.keyboardFrameMatchingViewHeightConstraint.constant = keyboardHeight
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.scrollToBottom()
		})
	}

	@objc func keyboardWillBeHidden(notification: NSNotification) {
		guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double,
			let curveRaw = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
				return
		}
		let animationOptions = UIViewAnimationOptions(rawValue: curveRaw)
		UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
			self.keyboardFrameMatchingViewHeightConstraint.constant = 0
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.scrollToBottom()
		})
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


