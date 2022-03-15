//
//  Presenter.swift
//  MVP_TableView
//
//  Created by Kirill Drozdov on 15.03.2022.
//

import Foundation
import UIKit

protocol UserPresenterDelegate:AnyObject
{
  func presentUser(user: [User])
  func presentAlert(title: String, message: String)
}


class UserPresenter
{
  typealias PresenteedDelegate = UserPresenterDelegate & UIViewController

  weak var delegate: PresenteedDelegate?

  public func getUser()
  {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
    let session = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data,   error == nil else{return}

      do{
        let response = try? JSONDecoder().decode([User].self, from: data)
        self.delegate?.presentUser(user: response!)
      }catch{
        print(error.localizedDescription)
      }
    }.resume()
  }

  public func setViewDelegate(delegate: PresenteedDelegate )
  {
    self.delegate = delegate
  }

  public func didTapUser(user: User)
  {
    let titile = user.name
    let message = "\(user.name) has an email of \(user.email) and username \(user.username)"
    let alert = UIAlertController(title: titile, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
    delegate?.present(alert,animated: true)
  }

}
