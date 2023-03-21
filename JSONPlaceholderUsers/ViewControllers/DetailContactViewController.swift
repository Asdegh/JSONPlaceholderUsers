//
//  DetailContactViewController.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit
import SnapKit

public final class DetailContactViewController: UIViewController {
	// MARK: - Interface
	private lazy var emailLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private lazy var phoneLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private lazy var userNameLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private lazy var adressLabel: UILabel = {
		let label = UILabel()
		return label
	}()
		var result: Users!
	public override func viewDidLoad() {
			super.viewDidLoad()
			view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
			view.addSubview(emailLabel)
			view.addSubview(phoneLabel)
			view.addSubview(userNameLabel)
			view.addSubview(adressLabel)
			setValues(with: result)
			initializeConstraints()
		}
		private func setValues(with result: Users) {
			emailLabel.text = "Email: \(result.email)"
			phoneLabel.text = "Phone: \(result.phone)"
			userNameLabel.text = "Username: \(result.username)"
			adressLabel.text = "City: \(result.address.city)"
		}
	// MARK: - Constraints
	private func initializeConstraints() {
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
		phoneLabel.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
		userNameLabel.snp.makeConstraints { make in
			make.top.equalTo(phoneLabel.snp.bottom).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
		adressLabel.snp.makeConstraints { make in
			make.top.equalTo(userNameLabel.snp.bottom).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
	}
}

