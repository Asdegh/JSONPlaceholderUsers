//
//  ViewController.swift
//  JSONPlaceholderUsers
//
//  Created by Alex Murphy on 21.03.2023.
//

import UIKit
import SnapKit

public final class MainViewController: UIViewController,
										UISearchBarDelegate,
										UITableViewDelegate,
										UITableViewDataSource,
										UISearchResultsUpdating {
	// MARK: - Properties
	var users: [Users] = []
	var searching = false
	var searchingUser: [Users] = []
	let searchController = UISearchController()

	private lazy var tableView: UITableView = {
		let table = UITableView()
		table.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()

	public override func viewDidLoad() {
		super.viewDidLoad()
		// view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		view.backgroundColor = .systemBackground
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.frame = view.bounds
		navigationItem.searchController = searchController
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Exit",
			style: .plain,
			target: self,
			action: #selector(dismissSelf))
		searchController.searchResultsUpdater = self
		definesPresentationContext = true
		setupNavigationBar()
		// fetchUsers()
		do {
			try fetchUsers { result in
				switch result {
				case .success(let users):
					self.users = users
				case .failure(let error):
					print(error)
				}
			}
		} catch {
			print(error)
		}
		configureSearchController()
	}
	// MARK: - Setup Navigation Bar
	public func setupNavigationBar() {
		title = "Users"
		navigationController?.navigationBar.prefersLargeTitles = true
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		navigationController?.navigationBar.standardAppearance = navBarAppearance
		navigationController?.navigationBar.standardAppearance = navBarAppearance
		navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
	}
	public func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		if !text.isEmpty {
			searching = true
			searchingUser.removeAll()
			for filteredUser in users {
				if filteredUser.name.lowercased().contains(text.lowercased()) {
					searchingUser.append(filteredUser)
				}
			}
		} else {
		searching = false
		searchingUser.removeAll()
		searchingUser = users
	}
	tableView.reloadData()
}

	public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searching = false
		searchingUser.removeAll()
		tableView.reloadData()
	}
	// MARK: - Search Controller
	private func configureSearchController() {
		searchController.loadViewIfNeeded()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.enablesReturnKeyAutomatically = false
		searchController.searchBar.returnKeyType = UIReturnKeyType.done
		self.navigationItem.searchController = searchController
		self.navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		searchController.searchBar.placeholder = "Search"
	}
	// MARK: - Exit function
	@objc
	private func dismissSelf() {
		dismiss(animated: true, completion: nil)

	}
	// MARK: - Fetch users
	private func fetchUsers(completion: @escaping(Result<[Users], Error>) -> Void) throws {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
			throw UserFetchError.invalidUrl
		}
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				completion(.failure(error))
			} else if let data = data {
				do {
					let result = try JSONDecoder().decode([Users].self, from: data)
					completion(.success(result))
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				} catch {
					completion(.failure(error))
				}
			} else {
				completion(.failure(UserFetchError.unknown))
			}
		}
		task.resume()
	}
//    private func fetchUsers() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let error = error {
//                print(error)
//            } else if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    self?.users = try decoder.decode([Users].self, from: data)
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                } catch let error {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
	// MARK: - Table View
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if searching {
			return searchingUser.count
		} else {
			return users.count
		}
	}
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
			cell.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 42/255, alpha: 1)
		var content = cell.defaultContentConfiguration()
		content.text = searching ? searchingUser[indexPath.row].name : users[indexPath.row].name
		cell.contentConfiguration = content
		return cell
	}
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let userName = searching ? searchingUser[indexPath.row] : users[indexPath.row]

		let detailVC = DetailContactViewController()

		detailVC.result = userName
		detailVC.title = userName.name
		navigationController?.pushViewController(detailVC, animated: true)
	}
}

