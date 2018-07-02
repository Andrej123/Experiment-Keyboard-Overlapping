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
	@IBOutlet fileprivate var redViewHeightConstraiont: NSLayoutConstraint!


	fileprivate let offset: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
		redViewHeightConstraiont.constant = offset
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
			self.redViewHeightConstraiont.constant = keyboardHeight + self.offset
			self.view.layoutIfNeeded()
		}, completion: nil)
	}

	@objc func keyboardWillBeHidden(notification: NSNotification) {
		guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double,
			let curveRaw = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
				return
		}
		let animationOptions = UIViewAnimationOptions(rawValue: curveRaw)
		UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
			self.redViewHeightConstraiont.constant = self.offset
			self.view.layoutIfNeeded()
		})
	}

}

