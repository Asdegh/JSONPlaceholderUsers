//
//  AppDelegate.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		window?.rootViewController = LoginViewController()
		return true
	}
}

