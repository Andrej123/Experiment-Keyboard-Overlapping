//
//  SimpleViewController.swift
//  Keyboard Overlapping Fix
//
//  Created by Andrej Krizmancic on 02/07/2018.
//  Copyright © 2018 Andrej Krizmancic. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {

	@IBOutlet fileprivate var greenView: UIView!
	@IBOutlet fileprivate var orangeView: UIView!
	@IBOutlet fileprivate var textField: UITextField!
	@IBOutlet fileprivate var keyboardFrameMatchingView: UIView!
	@IBOutlet fileprivate var keyboardFrameMatchingViewHeightConstraint: NSLayoutConstraint!


	fileprivate let offset: CGFloat = 10
	fileprivate var keyboardAvoider: KeyboardAvoider?

    override func viewDidLoad() {
        super.viewDidLoad()
		keyboardAvoider = KeyboardAvoider(keyboardFrameMatchingViewHeightConstraint: keyboardFrameMatchingViewHeightConstraint, superview: view)
    }


	deinit {
		let vc = String(describing: type(of: self))
		print("deinit \(vc)")
	}


	@IBAction fileprivate func addAccessoryTapped() {
		let frame = CGRect(x: 0, y: 0, width: 300, height: 30)
		let accesoryLabel = UILabel(frame: frame)
		accesoryLabel.text = "Hello! Accessory! 😎"
		accesoryLabel.backgroundColor = .magenta
		accesoryLabel.textAlignment = .center
		textField.inputAccessoryView = accesoryLabel
		textField.reloadInputViews()

	}

	@IBAction fileprivate func removeAccessoryTapped() {
		textField.inputAccessoryView = nil
		textField.reloadInputViews()
	}

	@IBAction fileprivate func dismissKeybaordTapped() {
		textField.resignFirstResponder()
	}

}


