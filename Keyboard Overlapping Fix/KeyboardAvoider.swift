//
//  KeyboardAvoider.swift
//  Keyboard Overlapping Fix
//
//  Created by Andrej Krizmancic on 02/07/2018.
//  Copyright © 2018 Andrej Krizmancic. All rights reserved.
//

import UIKit


/// Use KeyboardAvoider to manage for the keyboard to avoid overlapping the views.
/// Make sure to use a view that's supposed to mirror the keyboard as it's getting on the screen.
class KeyboardAvoider {

	fileprivate var keyboardFrameMatchingViewHeightConstraint: NSLayoutConstraint
	fileprivate var superview: UIView

	init(keyboardFrameMatchingViewHeightConstraint: NSLayoutConstraint, superview: UIView) {
		self.keyboardFrameMatchingViewHeightConstraint = keyboardFrameMatchingViewHeightConstraint
		self.superview = superview
		registerForKeyboardNotifications()
	}

	deinit {
		deregisterFromKeyboardNotifications()
	}

	fileprivate func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
	}

	fileprivate func deregisterFromKeyboardNotifications() {
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
			self.superview.layoutIfNeeded()
		}, completion: nil)
	}

	@objc func keyboardWillBeHidden(notification: NSNotification) {
		guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double,
			let curveRaw = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
				return
		}
		let animationOptions = UIViewAnimationOptions(rawValue: curveRaw)
		UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
			self.keyboardFrameMatchingViewHeightConstraint.constant = 0
			self.superview.layoutIfNeeded()
		})
	}

}

