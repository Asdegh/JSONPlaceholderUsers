//
//  Extension + Error.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import Foundation

extension MainViewController {
	enum UserFetchError: Error {
		case invalidUrl
		case unknown
	}
}
