//
//  UsersViewController.swift
//  MVP_TableView
//
//  Created by Kirill Drozdov on 15.03.2022.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserPresenterDelegate {

  // create table
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
  }()

  private var users = [User]()
  private let presenter = UserPresenter()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
    title = "Users"

    presenter.setViewDelegate(delegate: self )
    presenter.getUser()
    print(users.count)

  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = users[indexPath.row].name
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.didTapUser(user: users[ indexPath.row])
  }

  func presentUser(user: [User]) {
    self.users = user

    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  func presentAlert(title: String, message: String) {
   
  }


}

