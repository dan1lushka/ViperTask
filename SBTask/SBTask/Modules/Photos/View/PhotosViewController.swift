//
//  PhotosViewController.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// View: Displays what the Presenter tells it to display and relays user input back to the Presenter.

import UIKit

class PhotosViewController: UIViewController, PhotosViewProtocol {
  
  var presenter: PhotosPresenterProtocol?
  let cellReuseIdentifier = "photoCell"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    configureNavigationBar()
    configureTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    guard let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows else { return }
    tableView.reloadRows(at: indexPathsForVisibleRows, with: .none)
  }
}
