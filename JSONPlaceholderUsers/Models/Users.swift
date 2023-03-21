//
//  Users.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import Foundation

public struct Users: Codable {
	public let name: String
	public let username: String
	public let email: String
	public let address: Address
	public let phone: String
}

public struct Address: Codable {
	public let street: String
	public let city: String
}
