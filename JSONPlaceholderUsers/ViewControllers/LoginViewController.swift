//
//  LoginViewController.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
	private let loginButton = UIButton()
	private let reminderButton = UIButton()
	// private let registerButton = UIButton()
	private let user = User.getUserData()
	// MARK: - Interface
	public lazy var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "shutterstock_583717939")
		return imageView
	}()
	public lazy var loginTextField: CustomTextField = {
		let textField = CustomTextField()
		textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
		textField.backgroundColor = .white
		textField.attributedPlaceholder = NSAttributedString(
			string: "Login",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		textField.layer.cornerRadius = 8
		textField.textColor = .black
		textField.becomeFirstResponder()
		return textField
	}()
	public lazy var passwordTextField: CustomTextField = {
		let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
		textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
		textField.backgroundColor = .white
		textField.attributedPlaceholder = NSAttributedString(
			string: "Password",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		textField.layer.cornerRadius = 8
		textField.textColor = .black
		textField.isSecureTextEntry = true
		textField.becomeFirstResponder()
		return textField
	}()
	public func configureSubmitButton() {
		loginButton.configuration = .filled()
		loginButton.configuration?.title = "Submit"
		loginButton.configuration?.baseForegroundColor = .white
		loginButton.configuration?.baseBackgroundColor = UIColor(red: 80/255, green: 155/255, blue: 247/255, alpha: 1)
		loginButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
		addLoginButtonConstraints()
	}
	public func configureReminderButton() {
		reminderButton.configuration = .plain()
		reminderButton.configuration?.title = "Forgot Password?"
		reminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		reminderButton.configuration?.titleAlignment = .trailing
		reminderButton.configuration?.buttonSize = .mini
		reminderButton.configuration?.baseForegroundColor = .white
		reminderButton.addTarget(self, action: #selector(reminderPressed), for: .touchUpInside)
		addReminderButtonConstraints()
	}
	/*public func configureRegisterButton() {
		registerButton.configuration = .plain()
		registerButton.configuration?.title = "Register"
		registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		registerButton.configuration?.titleAlignment = .leading
		registerButton.configuration?.buttonSize = .mini
		registerButton.configuration?.baseForegroundColor = .white
		registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
		addRegisterButtonConstraints()
	}*/
	private lazy var footerLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.text = "© 2023 Company All Rights Reserved"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 13)
		return label
	}()
	private lazy var signInLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
		label.text = "Sign In"
		return label
	}()
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		view.addSubview(logoImageView)
		view.addSubview(loginTextField)
		view.addSubview(passwordTextField)
		view.addSubview(footerLabel)
		view.addSubview(signInLabel)
		initializeConstraints()
		configureSubmitButton()
		configureReminderButton()
		// configureRegisterButton()
	}
	// MARK: - Constraints
	public func initializeConstraints() {
		logoImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(70)
			make.centerX.equalToSuperview()
		}
		signInLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(50)
			// make.top.equalTo(view.safeAreaLayoutGuide).offset(220)
			make.bottom.equalTo(loginTextField.snp.top).offset(-10)
		}
		loginTextField.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom).offset(150)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(loginTextField.snp.bottom).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
		footerLabel.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(-10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
		}

	}
	public func addLoginButtonConstraints() {
		view.addSubview(loginButton)
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom).offset(10)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
			make.height.equalTo(50)
			make.width.equalTo(300)
		}
	}
	public func addReminderButtonConstraints() {
		view.addSubview(reminderButton)
		reminderButton.snp.makeConstraints { make in
			make.top.equalTo(loginButton.snp.bottom).offset(10)
			make.trailing.equalToSuperview().inset(50)
		}
	}
//	public func addRegisterButtonConstraints() {
//		view.addSubview(registerButton)
//		registerButton.snp.makeConstraints { make in
//			make.top.equalTo(loginButton.snp.bottom).offset(10)
//			make.leading.equalTo(view.safeAreaLayoutGuide).inset(50)
//			// make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
//		}
//	}
	// MARK: - Reminder
	@objc private func reminderPressed() {
		showAlert(title: "Hello!",
				  message: "Your login is \(user.login), Your password is \(user.password)")
	}
/*	@objc private func registerPressed() {
		let registerVC = UINavigationController(rootViewController: RegisterViewController())
//        detailVC.result = userName
//        detailVC.title = userName.name
		registerVC.modalPresentationStyle = .fullScreen
		present(registerVC, animated: true)
	} */
	// MARK: - Log in
	@objc func logInPressed() {
		guard
			loginTextField.text == user.login,
			passwordTextField.text == user.password
		else {
			showAlert(title: "Invalid login or password",
					  message: "Please, enter correct login and password",
					  textField: passwordTextField)
			return
		}
	// MARK: - Tab bar
		let tabBarVC = UITabBarController()
		let vc1 = UINavigationController(rootViewController: MainViewController())
		// let vc2 = UINavigationController(rootViewController: DivisionsViewController())
		// let vc3 = UINavigationController(rootViewController: StructureViewController())
		vc1.title = "Find employee"
		// vc2.title = "Divisions"
		// vc3.title = "Structure"
		tabBarVC.setViewControllers([vc1/*, vc2, vc3*/], animated: false)
//        tabBarVC.tabBar.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		tabBarVC.tabBar.backgroundColor = .black
		guard let items = tabBarVC.tabBar.items else {
			return
		}
		let images = ["magnifyingglass.circle.fill", "case.fill", "briefcase"]
		for x in 0..<items.count {
			items[x].image = UIImage(systemName: images[x])
		}
		tabBarVC.modalPresentationStyle = .fullScreen
		present(tabBarVC, animated: true)
	}
}
