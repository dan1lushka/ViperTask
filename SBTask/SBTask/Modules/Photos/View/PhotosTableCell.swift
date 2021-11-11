//
//  PhotosTableCell.swift
//  SBTask
//
//  Created by Daniel Rybak on 11/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import UIKit

class PhotosTableCell: UITableViewCell {
  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var photoLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.layer.cornerRadius = 10
    photoImage.layer.cornerRadius = 10
  }
  
}
