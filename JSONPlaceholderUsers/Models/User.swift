//
//  User.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import Foundation

public struct User {
	public let login: String
	public let password: String
	public let person: Person
	static func getUserData() -> User {
		User(
			login: "Login",
			password: "Password",
			person: Person(name: "Steve", surname: "Jobs")
		)
	}
}

public struct Person {
	public let name: String
	public let surname: String
	public var fullName: String {
		"\(name) \(surname)"
	}
}
