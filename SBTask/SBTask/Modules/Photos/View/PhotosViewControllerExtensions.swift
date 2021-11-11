//
//  PhotosViewControllerExtensions.swift
//  SBTask
//
//  Created by Daniel Rybak on 11/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import UIKit

// Mark: TableView handling
extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
  
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.photos?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PhotosTableCell
    
    guard let presenter = presenter else { return cell }
    guard let photos = presenter.photos else { return cell }
    
    cell.photoLabel.text = photos[indexPath.row].title
    
    let urlString = photos[indexPath.row].thumbnailUrl
    
    if let cachedData = presenter.getImageCacheData(for: urlString) {
      cell.photoImage.image = UIImage(data: cachedData)
    } else {
      presenter.presentImageDataFromNetwork(urlString: urlString)
      
      if let cachedData = presenter.getImageCacheData(for: urlString) {
        cell.photoImage.image = UIImage(data: cachedData)
      }
    }
    
    return cell
  }

}

// Mark: Navigation Bar handling
extension PhotosViewController {
  func configureNavigationBar() {
    navigationController?.navigationBar.isHidden = false
    
    navigationController?.navigationBar.barTintColor = UIColor.white
    
    // makes border not visible
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.layoutIfNeeded()
    
    // makes back button have no label
    navigationController?.navigationBar.topItem?.title = " "
    
    // sets Photos title
    let titleLbl = UILabel()
    guard let font = UIFont(name:"HelveticaNeue-Bold", size: 18.0) else { return }
    let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
    titleLbl.attributedText = NSAttributedString(string: "Photos", attributes: attributes)
    titleLbl.sizeToFit()
    self.navigationItem.titleView = titleLbl
  }
}

// Mark: View handlers for Presenter
extension PhotosViewController {
  func reloadData() {
    tableView.reloadData()
  }
}
