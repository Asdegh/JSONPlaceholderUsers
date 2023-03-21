//
//  CustomTextField.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit

public final class CustomTextField: UITextField {
	let insets: UIEdgeInsets
	init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
		self.insets = insets
		super.init(frame: .zero)
		layer.cornerRadius = 8
		layer.borderWidth = 1.5
		layer.borderColor = UIColor.lightGray.cgColor
	}
	required init?(coder: NSCoder) {
		fatalError()
	}
	public override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: insets)
	}
	public override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: insets)
	}
}
