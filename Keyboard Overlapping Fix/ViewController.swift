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



// MARK: - ViewController
class ViewController: UIViewController {

	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var xButton: UIButton!
	@IBOutlet fileprivate var sendButton: UIButton!
	@IBOutlet fileprivate var tableView: UITableView!
	@IBOutlet fileprivate var textField: UITextField!
	@IBOutlet fileprivate var bottomContstraint: NSLayoutConstraint!


	override func viewDidLoad() {
		super.viewDidLoad()
		registerForKeyboardNotifications()

//		let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)  )
//		accessoryView.backgroundColor = .green
//		textField.inputAccessoryView = accessoryView
	}

	@IBAction fileprivate func xButtonTapped() {
		print("\(#function)")

//		tableView.setContentOffset(<#T##contentOffset: CGPoint##CGPoint#>, animated: <#T##Bool#>)


	}

	@IBAction fileprivate func sendButtonTapped() {
		print("\(#function)")
		bottomContstraint.constant =  bottomContstraint.constant == 0 ? -250 : 0
		view.layoutIfNeeded()
		let lastSectionIndex = tableView.numberOfSections - 1
		let lastRowInLastSectionIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
		let indexPath = IndexPath(row: lastRowInLastSectionIndex, section: lastSectionIndex)
		tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)

	}

}


// MARK: - Behaviour to prevent keyboard overlapping
extension ViewController {
	func registerForKeyboardNotifications(){
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
	}

	func deregisterFromKeyboardNotifications(){
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}

	@objc func keyboardWasShown(notification: NSNotification){
		//Need to calculate keyboard exact size due to Apple suggestions
//		self.scrollView.isScrollEnabled = true
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size

		print("keyboardSize = \(keyboardSize!)")

		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)

//		self.scrollView.contentInset = contentInsets
//		self.scrollView.scrollIndicatorInsets = contentInsets
		self.tableView.contentInset = contentInsets
		self.tableView.scrollIndicatorInsets = contentInsets

		var aRect : CGRect = self.view.frame
		aRect.size.height -= keyboardSize!.height
//		if let activeField = self.activeField {
//			if (!aRect.contains(activeField.frame.origin)){
//				self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
//			}
//		}
//		if let activeField = self.textField {
//			if (!aRect.contains(activeField.frame.origin)){
//				self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
				let lastSectionIndex = tableView.numberOfSections - 1
				let lastRowInLastSectionIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
				let indexPath = IndexPath(row: lastRowInLastSectionIndex, section: lastSectionIndex)
				self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//			}
//		}





	}

	@objc func keyboardWillBeHidden(notification: NSNotification){
		//Once keyboard disappears, restore original positions
		var info = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
		let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
//		self.scrollView.contentInset = contentInsets
//		self.scrollView.scrollIndicatorInsets = contentInsets
//		self.view.endEditing(true)
//		self.scrollView.isScrollEnabled = false
		tableView.contentInset = contentInsets
		tableView.scrollIndicatorInsets = contentInsets
	}

	//	func textFieldDidBeginEditing(_ textField: UITextField){
	//		activeField = textField
	//	}
	//
	//	func textFieldDidEndEditing(_ textField: UITextField){
	//		activeField = nil
	//	}


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

}


