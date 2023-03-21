//
//  Extension + Alert.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit

extension LoginViewController {
	func showAlert(title: String, message: String, textField: UITextField? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default) { _ in
			textField?.text = nil
		}
		alert.addAction(okAction)
		present(alert, animated: true)
	}
}
