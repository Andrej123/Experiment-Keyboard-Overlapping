//
//  SimpleViewController.swift
//  Keyboard Overlapping Fix
//
//  Created by Andrej Krizmancic on 02/07/2018.
//  Copyright © 2018 Andrej Krizmancic. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {

	@IBOutlet fileprivate var redView: UIView!
	@IBOutlet fileprivate var greenView: UIView!
	@IBOutlet fileprivate var orangeView: UIView!
	@IBOutlet fileprivate var textField: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()
		registerForKeyboardNotifications()
    }

	@IBAction fileprivate func button1Tapped() {
		print("ddd \(#function)")
	}

	@IBAction fileprivate func button2Tapped() {
		print("ddd \(#function)")
	}

	@IBAction fileprivate func button3Tapped() {
		textField.resignFirstResponder()
	}

}



// MARK: - Behaviour to prevent keyboard overlapping
extension SimpleViewController {
	func registerForKeyboardNotifications() {
		print("ddd \(#function)")
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
	}

	func deregisterFromKeyboardNotifications() {
		print("ddd \(#function)")
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}

	@objc func keyboardWillBeShown(notification: NSNotification) {
		print("ddd \(#function)")
		guard let keyboardHeightValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
			print("ddd Error \(#line), could not get height")
			return
		}
		let keyboardHeight = keyboardHeightValue.cgRectValue.height
		print("ddd keyboardHeight = \(keyboardHeight)")
	}

	@objc func keyboardWillBeHidden(notification: NSNotification) {
		print("ddd \(#function)")
		guard let keyboardHeightValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
			print("ddd Error \(#line), could not get height")
			return
		}
		let keyboardHeight = keyboardHeightValue.cgRectValue.height
		print("ddd keyboardHeight = \(keyboardHeight)")
	}

}

